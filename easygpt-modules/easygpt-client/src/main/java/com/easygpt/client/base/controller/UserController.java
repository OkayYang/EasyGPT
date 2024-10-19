package com.easygpt.client.base.controller;

import java.util.List;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;

import com.easygpt.common.core.utils.uuid.IdUtils;
import com.easygpt.common.core.utils.uuid.UUID;
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
import com.easygpt.client.base.domain.User;
import com.easygpt.client.base.service.IUserService;
import com.easygpt.common.core.web.controller.BaseController;
import com.easygpt.common.core.web.domain.AjaxResult;
import com.easygpt.common.core.utils.poi.ExcelUtil;
import com.easygpt.common.core.web.page.TableDataInfo;

/**
 * 用户Controller
 *
 * @author xiaoyang
 * @date 2024-10-16
 */
@RestController
@RequestMapping("/user")
public class UserController extends BaseController
{
    @Autowired
    private IUserService userService;

    /**
     * 查询用户列表
     */
    @RequiresPermissions("client:user:list")
    @GetMapping("/list")
    public TableDataInfo list(User user)
    {
        startPage();
        List<User> list = userService.selectUserList(user);
        return getDataTable(list);
    }

    /**
     * 导出用户列表
     */
    @RequiresPermissions("client:user:export")
    @Log(title = "用户", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, User user)
    {
        List<User> list = userService.selectUserList(user);
        ExcelUtil<User> util = new ExcelUtil<User>(User.class);
        util.exportExcel(response, list, "用户数据");
    }

    /**
     * 获取用户详细信息
     */
    @RequiresPermissions("client:user:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(userService.selectUserById(id));
    }

    /**
     * 新增用户
     */
    @RequiresPermissions("client:user:add")
    @Log(title = "用户", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody User user)
    {
        return toAjax(userService.insertUser(user));
    }

    /**
     * 修改用户
     */
    @RequiresPermissions("client:user:edit")
    @Log(title = "用户", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody User user)
    {
        return toAjax(userService.updateUser(user));
    }

    /**
     * 删除用户
     */
    @RequiresPermissions("client:user:remove")
    @Log(title = "用户", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(userService.deleteUserByIds(ids));
    }

}
