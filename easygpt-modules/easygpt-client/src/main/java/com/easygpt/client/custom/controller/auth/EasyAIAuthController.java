package com.easygpt.client.custom.controller.auth;

import com.easygpt.client.custom.controller.auth.vo.LoginReqBody;
import com.easygpt.client.custom.controller.auth.vo.RegisterReqBody;
import com.easygpt.client.custom.controller.auth.vo.SendEmailCodeReqBody;
import com.easygpt.client.custom.model.EasyAILoginUser;
import com.easygpt.client.custom.service.EasyAIEmailSendService;
import com.easygpt.client.custom.service.EasyAITokenService;
import com.easygpt.client.custom.service.user.IUserCustomService;
import com.easygpt.common.core.domain.R;
import com.easygpt.common.core.web.domain.AjaxResult;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Tag(name = "EasyAI用户端 - 认证")
@RestController
@RequestMapping("/easyai/auth")
@Validated
public class EasyAIAuthController {
    @Autowired
    private EasyAIEmailSendService easyAIEmailSendService;

    @Autowired
    private IUserCustomService easyAIUserCustomService;

    @Autowired
    private EasyAITokenService easyAITokenService;



    @Operation(summary = "获取邮箱验证吗")
    @PostMapping("/send-email-code")
    public AjaxResult sendEmailCode(@RequestBody @Valid SendEmailCodeReqBody sendEmailCodeReqBody){
        boolean isSent = easyAIEmailSendService.sendCode(sendEmailCodeReqBody);
        if (isSent) {
            return AjaxResult.success("Verification code sent successfully.");
        } else {

            return AjaxResult.error("Failed to send verification code.");
        }
    }

    @Operation(summary = "用户登陆")
    @PostMapping("/login")
    public R<?> login(@RequestBody @Valid LoginReqBody loginReqBody){
        // 用户登录
        EasyAILoginUser easyAILoginUser = easyAIUserCustomService.login(loginReqBody);
        // 获取登录token
        return R.ok(easyAITokenService.createToken(easyAILoginUser),"Login successfully.");
    }

    @Operation(summary = "用户注册")
    @PostMapping("/register")
    public AjaxResult register(@RequestBody @Valid RegisterReqBody registerReqBody,@RequestParam(value = "invite",required = false) String inviteUid){

        easyAIUserCustomService.register(registerReqBody, inviteUid);
        return AjaxResult.success("Register successfully.");

    }

}
