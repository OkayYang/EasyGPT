package com.easygpt.client.custom.mapper;

import com.easygpt.client.base.domain.User;
import com.easygpt.client.base.mapper.UserMapper;

public interface UserCustomMapper {


    /**
     * 查询用户
     *
     * @param username 用户账户
     * @return 用户
     */
    public User selectUserByUserName(String username);

}
