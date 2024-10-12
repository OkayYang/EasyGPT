package com.easygpt.client;


import com.easygpt.common.security.annotation.EnableCustomConfig;
import com.easygpt.common.security.annotation.EnableRyFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 用户模块
 *
 * @author xiaoyang
 */
@EnableCustomConfig
@EnableRyFeignClients
@SpringBootApplication
public class RuoYiClientApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(RuoYiClientApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  用户模块启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                " .-------.       ____     __        \n" +
                " |  _ _   \\      \\   \\   /  /    \n" +
                " | ( ' )  |       \\  _. /  '       \n" +
                " |(_ o _) /        _( )_ .'         \n" +
                " | (_,_).' __  ___(_ o _)'          \n" +
                " |  |\\ \\  |  ||   |(_,_)'         \n" +
                " |  | \\ `'   /|   `-'  /           \n" +
                " |  |  \\    /  \\      /           \n" +
                " ''-'   `'-'    `-..-'              ");
    }
}
