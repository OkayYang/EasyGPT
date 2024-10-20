package com.easygpt.client.custom.service.user;

import com.easygpt.client.base.domain.User;
import com.easygpt.client.base.mapper.UserMapper;
import com.easygpt.client.base.service.impl.UserServiceImpl;
import com.easygpt.client.custom.annotation.InviteReward;
import com.easygpt.client.custom.controller.auth.vo.LoginReqBody;
import com.easygpt.client.custom.controller.auth.vo.RegisterReqBody;
import com.easygpt.client.custom.controller.user.vo.UserInfoRespBody;
import com.easygpt.client.custom.enums.EmailCodeSceneEnum;
import com.easygpt.client.custom.mapper.UserCustomMapper;
import com.easygpt.client.custom.model.EasyAILoginUser;
import com.easygpt.client.custom.service.EasyAIPasswordService;
import com.easygpt.client.custom.utils.RedisKeyUtils;
import com.easygpt.common.core.constant.CacheConstants;
import com.easygpt.common.core.enums.UserStatus;
import com.easygpt.common.core.exception.ServiceException;
import com.easygpt.common.core.text.Convert;
import com.easygpt.common.core.utils.DateUtils;
import com.easygpt.common.core.utils.StringUtils;
import com.easygpt.common.core.utils.ip.IpUtils;
import com.easygpt.common.redis.service.RedisService;
import com.easygpt.common.security.utils.SecurityUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.regex.Pattern;

@Service
public class IUserCustomServiceImpl  implements IUserCustomService {

    @Autowired
    private UserCustomMapper easyAIUserCustomMapper;

//    @Autowired
//    private UserMapper userMapper;

    @Autowired
    private RedisService redisService;

    @Autowired
    private EasyAIPasswordService passwordService;


    @Override
    public EasyAILoginUser login(LoginReqBody loginReqBody) {
        String username = loginReqBody.getUsername();
        String password = loginReqBody.getPassword();
        // 用户名或密码为空 错误
        if (StringUtils.isAnyBlank(username, password))
        {
            throw new ServiceException("用户/密码必须填写");
        }
        // IP黑名单校验
        String blackStr = Convert.toStr(redisService.getCacheObject(CacheConstants.SYS_LOGIN_BLACKIPLIST));
        if (IpUtils.isMatchedIp(blackStr, IpUtils.getIpAddr()))
        {
            throw new ServiceException("很遗憾，访问IP已被列入系统黑名单");
        }
        User user = easyAIUserCustomMapper.selectUserByUserName(username);
        if (StringUtils.isNull(user))
        {
            throw new ServiceException("登录用户：" + username + " 不存在");
        }

        if (UserStatus.DELETED.getCode().equals(user.getStatus()))
        {
            throw new ServiceException("对不起，您的账号：" + username + " 已被删除");
        }
        if (UserStatus.DISABLE.getCode().equals(user.getStatus()))
        {
            throw new ServiceException("对不起，您的账号：" + username + " 已停用");
        }
        passwordService.validate(user, password);
        EasyAILoginUser easyAILoginUser = new EasyAILoginUser();
        easyAILoginUser.setEasyAIUser(user);

        user.setLoginIp(IpUtils.getIpAddr());
        user.setLoginDate(DateUtils.getNowDate());
        easyAIUserCustomMapper.updateUser(user);

        return easyAILoginUser;
    }

    /**
     * 注册
     */
    @InviteReward
    public User register(RegisterReqBody registerReqBody,String inviteUid) {
        String username = registerReqBody.getUsername();
        String password = registerReqBody.getPassword();
        String code = registerReqBody.getCode();
        User user = easyAIUserCustomMapper.selectUserByUserName(username);

        if (!StringUtils.isNull(user)) {
            throw new ServiceException("用户已存在");
        }

        // 用户名或密码为空 错误
        if (StringUtils.isAnyBlank(username, password)) {
            throw new ServiceException("用户/密码必须填写");
        }

        // 检查用户名是否是邮箱
        if (!isValidEmail(username)) {
            throw new ServiceException("用户名必须是有效的邮箱地址");
        }


        // 检查密码长度和复杂度（数字字母组合，至少6位）
        if (password.length() < 6) {
            throw new ServiceException("密码长度必须不少于6位");
        }
        if (!isValidPassword(password)) {
            throw new ServiceException("密码必须包含数字和字母的组合");
        }

        EmailCodeSceneEnum registerScene = EmailCodeSceneEnum.USER_REGISTER;
        String redisKey = RedisKeyUtils.generateVerificationKey(username, registerScene.name());  // 使用枚举的名称构造 Redis key

        System.out.println("register:redisKey: " + redisKey);
        if (!redisService.hasKey(redisKey)) {
            throw new ServiceException("验证码已过期，请重新获取");
        }
        String redisCode = redisService.getCacheObject(redisKey);

        if (code==null||!code.equals(redisCode)) {
            throw new ServiceException("验证码错误");
        }
        // 注册用户逻辑
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(SecurityUtils.encryptPassword(password));
        newUser.setCreateTime(DateUtils.getNowDate());
        int result = easyAIUserCustomMapper.insertUser(newUser);
        if (result != 1) {
            throw new ServiceException("注册失败");
        }
        redisService.deleteObject(redisKey);
        return newUser;
    }

    @Override
    public UserInfoRespBody getUserInfo(Long userId) {
        UserInfoRespBody userInfoRespBody = new UserInfoRespBody();
        User user = easyAIUserCustomMapper.selectUserById(userId);
        BeanUtils.copyProperties(user, userInfoRespBody);
        return userInfoRespBody;
    }


    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }

    private boolean isValidPassword(String password) {
        // 必须包含数字和字母的组合
        String passwordRegex = "^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{6,}$";
        Pattern pattern = Pattern.compile(passwordRegex);
        return pattern.matcher(password).matches();
    }


}
