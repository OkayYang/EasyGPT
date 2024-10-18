package com.easygpt.client.custom.service;

import com.easygpt.client.custom.constant.EasyAIConstants;
import com.easygpt.client.custom.controller.auth.vo.SendEmailCodeReqBody;
import com.easygpt.client.custom.enums.EmailCodeSceneEnum;
import com.easygpt.client.custom.utils.RedisKeyUtils;
import com.easygpt.common.email.service.EmailService;
import com.easygpt.common.redis.service.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Component;

import java.util.Random;
import java.util.concurrent.TimeUnit;


@Component
public class EasyAIEmailSendService {
    @Autowired
    private RedisService redisService;
    @Autowired
    private EmailService emailService;

    // 生成验证码并发送到邮箱
    public boolean sendCode(SendEmailCodeReqBody sendEmailCodeReqBody) {
        String email = sendEmailCodeReqBody.getEmail();
        Integer scene = sendEmailCodeReqBody.getScene();  // 使用 scene 代替 type

        // 1. 获取对应的邮件场景枚举
        EmailCodeSceneEnum emailSceneEnum = EmailCodeSceneEnum.getByScene(scene);
        if (emailSceneEnum == null) {
            throw new IllegalArgumentException("无效的邮件场景");  // 校验 scene 是否有效
        }

        // 2. 生成验证码
        String verificationCode = generateVerificationCode();

        // 3. 构造 Redis 的 Key，确保唯一性，避免不同类型的验证码冲突
        String redisKey = RedisKeyUtils.generateVerificationKey(email, emailSceneEnum.name());  // 使用枚举的名称构造 Redis key

        System.out.println("redisKey: " + redisKey);
        System.out.println("verificationCode:" + verificationCode);

        //4. 发送邮件
        if (sendEmail(email, verificationCode)) {
            // 5. 将验证码存入 Redis，设置过期时间
            redisService.setCacheObject(redisKey, verificationCode, EasyAIConstants.EMAIL_CODE_EXPIRATION, TimeUnit.MINUTES);
            return true;
        } else {
            return false;
        }
    }

    private String generateVerificationCode() {
        return String.valueOf(new Random().nextInt(899999) + 100000); // 生成六位随机验证码
    }


    private boolean sendEmail(String email, String code) {
        try {
            String subject = "Your Verification Code";
            String text = "Your verification code is: " + code + "\nThis code will expire in 5 minutes.";
            SimpleMailMessage message = new SimpleMailMessage();
            return emailService.sendSimpleMail(email, subject, text);
        } catch (Exception e) {
            // 处理发送失败的情况，例如记录日志
            e.printStackTrace();
            return false;
        }
    }
}
