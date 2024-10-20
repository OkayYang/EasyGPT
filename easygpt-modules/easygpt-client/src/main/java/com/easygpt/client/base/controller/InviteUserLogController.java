package com.easygpt.client.base.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.easygpt.common.log.annotation.Log;
import com.easygpt.common.log.enums.BusinessType;
import com.easygpt.common.security.annotation.RequiresPermissions;
import com.easygpt.client.base.domain.InviteUserLog;
import com.easygpt.client.base.service.IInviteUserLogService;
import com.easygpt.common.core.web.controller.BaseController;
import com.easygpt.common.core.web.domain.AjaxResult;
import com.easygpt.common.core.utils.poi.ExcelUtil;
import com.easygpt.common.core.web.page.TableDataInfo;

/**
 * 用户邀请日志Controller
 *
 * @author xiaoshuaige
 * @date 2024-10-20
 */
@RestController
@RequestMapping("/invite_log")
public class InviteUserLogController extends BaseController
{
    @Autowired
    private IInviteUserLogService inviteUserLogService;

    /**
     * 查询用户邀请日志列表
     */
    @RequiresPermissions("client:invite_log:list")
    @GetMapping("/list")
    public TableDataInfo list(InviteUserLog inviteUserLog)
    {
        startPage();
        List<InviteUserLog> list = inviteUserLogService.selectInviteUserLogList(inviteUserLog);
        return getDataTable(list);
    }

    /**
     * 导出用户邀请日志列表
     */
    @RequiresPermissions("client:invite_log:export")
    @Log(title = "用户邀请日志", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, InviteUserLog inviteUserLog)
    {
        List<InviteUserLog> list = inviteUserLogService.selectInviteUserLogList(inviteUserLog);
        ExcelUtil<InviteUserLog> util = new ExcelUtil<InviteUserLog>(InviteUserLog.class);
        util.exportExcel(response, list, "用户邀请日志数据");
    }

    /**
     * 获取用户邀请日志详细信息
     */
    @RequiresPermissions("client:invite_log:query")
    @GetMapping(value = "/{inviteId}")
    public AjaxResult getInfo(@PathVariable("inviteId") Long inviteId)
    {
        return success(inviteUserLogService.selectInviteUserLogByInviteId(inviteId));
    }

    /**
     * 新增用户邀请日志
     */
    @RequiresPermissions("client:invite_log:add")
    @Log(title = "用户邀请日志", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody InviteUserLog inviteUserLog)
    {
        return toAjax(inviteUserLogService.insertInviteUserLog(inviteUserLog));
    }

    /**
     * 修改用户邀请日志
     */
    @RequiresPermissions("client:invite_log:edit")
    @Log(title = "用户邀请日志", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody InviteUserLog inviteUserLog)
    {
        return toAjax(inviteUserLogService.updateInviteUserLog(inviteUserLog));
    }

    /**
     * 删除用户邀请日志
     */
    @RequiresPermissions("client:invite_log:remove")
    @Log(title = "用户邀请日志", businessType = BusinessType.DELETE)
	@DeleteMapping("/{inviteIds}")
    public AjaxResult remove(@PathVariable Long[] inviteIds)
    {
        return toAjax(inviteUserLogService.deleteInviteUserLogByInviteIds(inviteIds));
    }
}
