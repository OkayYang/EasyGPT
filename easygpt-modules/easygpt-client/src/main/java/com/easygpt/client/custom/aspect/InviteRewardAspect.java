package com.easygpt.client.custom.aspect;

import com.easygpt.client.base.domain.InviteUserLog;
import com.easygpt.client.base.domain.RewardConfig;
import com.easygpt.client.base.domain.User;
import com.easygpt.client.base.mapper.InviteUserLogMapper;
import com.easygpt.client.base.mapper.RewardConfigMapper;
import com.easygpt.client.custom.mapper.UserCustomMapper;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.easygpt.client.custom.controller.auth.vo.RegisterReqBody;

/**
 * @author XuShiPing
 * @since 2024/10/20  19:26
 */

@Aspect
@Component
public class InviteRewardAspect {

    @Autowired
    private RewardConfigMapper rewardConfigMapper;

    @Autowired
    private UserCustomMapper userCustomMapper;

    @Autowired
    private InviteUserLogMapper inviteUserLogMapper;

    /*
         邀请奖励 和 邀请记录
     */
    @AfterReturning(value = "@annotation(com.easygpt.client.custom.annotation.InviteReward) " +
            "&& args(registerReqBody, inviteUid)", returning = "newUser",
            argNames = "joinPoint,registerReqBody,inviteUid,newUser")
    public void handleInviteReward(JoinPoint joinPoint, RegisterReqBody registerReqBody, String inviteUid, User newUser) {
        if (inviteUid != null) {
            try {
                long id = Long.parseLong(inviteUid);
                RewardConfig rewardConfig = rewardConfigMapper.selectRewardConfigByName("invite_reward");

                // 邀请人信息
                User rewardedUser = userCustomMapper.selectUserById(id);

                // 是否存在邀请人
                boolean hasInviteUser = rewardedUser != null;

                // 邀请记录
                if (hasInviteUser) {
                    InviteUserLog inviteUserLog = new InviteUserLog();
                    inviteUserLog.setInviteEmail(rewardedUser.getUsername());
                    inviteUserLog.setInvitedEmail(newUser.getUsername());
                    // 若未开启 则为空
                    if (rewardConfig.getStatus().equals("1")) {
                        inviteUserLog.setReward(rewardConfig.getReward());
                    }
                    inviteUserLogMapper.insertInviteUserLog(inviteUserLog);
                }

                // 判断邀请奖励状态是否开启 未开启直接结束
                if (rewardConfig != null && rewardConfig.getStatus().equals("1")) {
                    rewardedUser = userCustomMapper.selectUserById(id);
                    if (rewardedUser != null) {
                        userCustomMapper.addUserPowerById(id, rewardConfig.getReward());
                    }
                }

            } catch (NumberFormatException e) {
                System.out.println("邀请码错误");
            }
        }
    }
}
//

