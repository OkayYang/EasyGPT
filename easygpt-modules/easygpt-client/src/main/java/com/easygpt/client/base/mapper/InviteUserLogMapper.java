package com.easygpt.client.base.mapper;

import com.easygpt.client.base.domain.InviteUserLog;

import java.util.List;


/**
 * 用户邀请日志Mapper接口
 *
 * @author xiaoshuaige
 * @date 2024-10-20
 */
public interface InviteUserLogMapper
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
     * 删除用户邀请日志
     *
     * @param inviteId 用户邀请日志主键
     * @return 结果
     */
    public int deleteInviteUserLogByInviteId(Long inviteId);

    /**
     * 批量删除用户邀请日志
     *
     * @param inviteIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteInviteUserLogByInviteIds(Long[] inviteIds);
}
