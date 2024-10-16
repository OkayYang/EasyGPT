package com.easygpt.client.custom.service.user;

import com.easygpt.client.base.service.IUserService;
import com.easygpt.client.custom.controller.auth.vo.LoginReqBody;
import com.easygpt.client.custom.controller.auth.vo.RegisterReqBody;
import com.easygpt.client.custom.controller.user.vo.UserInfoRespBody;
import com.easygpt.client.custom.model.EasyAILoginUser;

public interface IUserCustomService {
    /**
     * 用户登陆
     *
     * @param loginReqBody 用户登陆请求body
     * @return 用户
     */
    public EasyAILoginUser login (LoginReqBody loginReqBody);

    /**
     * 用户注册
     * @param registerReqBody 注册信息
     * @param inviteUid 邀请码
     */
    public void register(RegisterReqBody registerReqBody, String inviteUid);

    /**
     * 获取用户登陆信息
     * @param userId 用户id
     * @return 用户信息VO
     */
    public UserInfoRespBody getUserInfo(Long userId);


}
