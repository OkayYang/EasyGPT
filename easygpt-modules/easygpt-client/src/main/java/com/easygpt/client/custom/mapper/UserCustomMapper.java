package com.easygpt.client.custom.mapper;

import com.easygpt.client.base.domain.User;
import com.easygpt.client.base.mapper.UserMapper;
import org.apache.ibatis.annotations.Param;

public interface UserCustomMapper extends UserMapper{

    /**
     * 查询用户
     *
     * @param username 用户账户
     * @return 用户
     */
    public User selectUserByUserName(String username);

    public User selectUserById(Long id);

    public int addUserPowerById(@Param("id") Long id, @Param("reward") Long reward);
}
