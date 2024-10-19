package com.easygpt.client.base.service.impl;

import java.util.List;
import com.easygpt.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.easygpt.client.base.mapper.CardKeyMapper;
import com.easygpt.client.base.domain.CardKey;
import com.easygpt.client.base.service.ICardKeyService;

/**
 * 卡密Service业务层处理
 *
 * @author xiaoshuaige
 * @date 2024-10-18
 */
@Service
public class CardKeyServiceImpl implements ICardKeyService
{
    @Autowired
    private CardKeyMapper cardKeyMapper;

    /**
     * 查询卡密
     *
     * @param cardKeyId 卡密主键
     * @return 卡密
     */
    @Override
    public CardKey selectCardKeyByCardKeyId(Long cardKeyId)
    {
        return cardKeyMapper.selectCardKeyByCardKeyId(cardKeyId);
    }

    /**
     * 查询卡密列表
     *
     * @param cardKey 卡密
     * @return 卡密
     */
    @Override
    public List<CardKey> selectCardKeyList(CardKey cardKey)
    {
        return cardKeyMapper.selectCardKeyList(cardKey);
    }

    /**
     * 新增卡密
     *
     * @param cardKey 卡密
     * @return 结果
     */
    @Override
    public int insertCardKey(CardKey cardKey)
    {
        cardKey.setCreateTime(DateUtils.getNowDate());
        return cardKeyMapper.insertCardKey(cardKey);
    }

    /**
     * 修改卡密
     *
     * @param cardKey 卡密
     * @return 结果
     */
    @Override
    public int updateCardKey(CardKey cardKey)
    {
        return cardKeyMapper.updateCardKey(cardKey);
    }

    /**
     * 批量删除卡密
     *
     * @param cardKeyIds 需要删除的卡密主键
     * @return 结果
     */
    @Override
    public int deleteCardKeyByCardKeyIds(Long[] cardKeyIds)
    {
        return cardKeyMapper.deleteCardKeyByCardKeyIds(cardKeyIds);
    }

    /**
     * 删除卡密信息
     *
     * @param cardKeyId 卡密主键
     * @return 结果
     */
    @Override
    public int deleteCardKeyByCardKeyId(Long cardKeyId)
    {
        return cardKeyMapper.deleteCardKeyByCardKeyId(cardKeyId);
    }

    @Override
    public int batchInsertCardKey(List<CardKey> cardKeyList) {
        return cardKeyMapper.batchInsertCardKey(cardKeyList);
    }
}
