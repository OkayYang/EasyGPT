package com.easygpt.client.base.service;

import java.util.List;
import com.easygpt.client.base.domain.InviteUserLog;

/**
 * 用户邀请日志Service接口
 *
 * @author xiaoshuaige
 * @date 2024-10-20
 */
public interface IInviteUserLogService
{
    /**
     * 查询用户邀请日志
     *
     * @param inviteId 用户邀请日志主键
     * @return 用户邀请日志
     */
    public InviteUserLog selectInviteUserLogByInviteId(Long inviteId);

    /**
     * 查询用户邀请日志列表
     *
     * @param inviteUserLog 用户邀请日志
     * @return 用户邀请日志集合
     */
    public List<InviteUserLog> selectInviteUserLogList(InviteUserLog inviteUserLog);

    /**
     * 新增用户邀请日志
     *
     * @param inviteUserLog 用户邀请日志
     * @return 结果
     */
    public int insertInviteUserLog(InviteUserLog inviteUserLog);

    /**
     * 修改用户邀请日志
     *
     * @param inviteUserLog 用户邀请日志
     * @return 结果
     */
    public int updateInviteUserLog(InviteUserLog inviteUserLog);

    /**
     * 批量删除用户邀请日志
     *
     * @param inviteIds 需要删除的用户邀请日志主键集合
     * @return 结果
     */
    public int deleteInviteUserLogByInviteIds(Long[] inviteIds);

    /**
     * 删除用户邀请日志信息
     *
     * @param inviteId 用户邀请日志主键
     * @return 结果
     */
    public int deleteInviteUserLogByInviteId(Long inviteId);
}
