package com.easygpt.client.base.service.impl;

import java.util.List;
import com.easygpt.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.easygpt.client.base.mapper.InviteUserLogMapper;
import com.easygpt.client.base.domain.InviteUserLog;
import com.easygpt.client.base.service.IInviteUserLogService;

/**
 * 用户邀请日志Service业务层处理
 *
 * @author xiaoshuaige
 * @date 2024-10-20
 */
@Service
public class InviteUserLogServiceImpl implements IInviteUserLogService
{
    @Autowired
    private InviteUserLogMapper inviteUserLogMapper;

    /**
     * 查询用户邀请日志
     *
     * @param inviteId 用户邀请日志主键
     * @return 用户邀请日志
     */
    @Override
    public InviteUserLog selectInviteUserLogByInviteId(Long inviteId)
    {
        return inviteUserLogMapper.selectInviteUserLogByInviteId(inviteId);
    }

    /**
     * 查询用户邀请日志列表
     *
     * @param inviteUserLog 用户邀请日志
     * @return 用户邀请日志
     */
    @Override
    public List<InviteUserLog> selectInviteUserLogList(InviteUserLog inviteUserLog)
    {
        return inviteUserLogMapper.selectInviteUserLogList(inviteUserLog);
    }

    /**
     * 新增用户邀请日志
     *
     * @param inviteUserLog 用户邀请日志
     * @return 结果
     */
    @Override
    public int insertInviteUserLog(InviteUserLog inviteUserLog)
    {
        inviteUserLog.setCreateTime(DateUtils.getNowDate());
        return inviteUserLogMapper.insertInviteUserLog(inviteUserLog);
    }

    /**
     * 修改用户邀请日志
     *
     * @param inviteUserLog 用户邀请日志
     * @return 结果
     */
    @Override
    public int updateInviteUserLog(InviteUserLog inviteUserLog)
    {
        return inviteUserLogMapper.updateInviteUserLog(inviteUserLog);
    }

    /**
     * 批量删除用户邀请日志
     *
     * @param inviteIds 需要删除的用户邀请日志主键
     * @return 结果
     */
    @Override
    public int deleteInviteUserLogByInviteIds(Long[] inviteIds)
    {
        return inviteUserLogMapper.deleteInviteUserLogByInviteIds(inviteIds);
    }

    /**
     * 删除用户邀请日志信息
     *
     * @param inviteId 用户邀请日志主键
     * @return 结果
     */
    @Override
    public int deleteInviteUserLogByInviteId(Long inviteId)
    {
        return inviteUserLogMapper.deleteInviteUserLogByInviteId(inviteId);
    }
}
