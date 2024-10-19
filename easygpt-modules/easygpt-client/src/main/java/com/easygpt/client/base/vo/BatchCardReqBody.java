package com.easygpt.client.base.vo;
import java.util.Date;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.Valid;
import javax.validation.constraints.*;

/**
 * BatchCardReqBody
 */
@javax.annotation.Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2024-10-18T23:48:11.890135300+08:00[Asia/Shanghai]")

public class BatchCardReqBody   {
    @JsonProperty("reward")
    @Min(0)
    private Long reward;

    @JsonProperty("generateNum")
    @Min(1)
    private Long generateNum;

    @JsonProperty("category")
    private String category;

    @JsonProperty("expireTime")
    private Date expireTime;

    public BatchCardReqBody reward(Long reward) {
        this.reward = reward;
        return this;
    }

    /**
     * Get reward
     * @return reward
     */
    @ApiModelProperty(required = true, value = "")
    @NotNull
    public Long getReward() {
        return reward;
    }

    public void setReward(Long reward) {
        this.reward = reward;
    }

    public BatchCardReqBody generateNum(Long generateNum) {
        this.generateNum = generateNum;
        return this;
    }

    /**
     * Get generateNum
     * @return generateNum
     */
    @ApiModelProperty(required = true, value = "")
    @NotNull


    public Long getGenerateNum() {
        return generateNum;
    }

    public void setGenerateNum(Long generateNum) {
        this.generateNum = generateNum;
    }

    public BatchCardReqBody category(String category) {
        this.category = category;
        return this;
    }

    /**
     * 分组
     * @return category
     */
    @ApiModelProperty(required = true, value = "分组")
    @NotNull


    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BatchCardReqBody expireTime(Date expireTime) {
        this.expireTime = expireTime;
        return this;
    }

    /**
     * Get expireTime
     * @return expireTime
     */
    @ApiModelProperty(required = true, value = "")
    @NotNull
    public Date getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(Date expireTime) {
        this.expireTime = expireTime;
    }


    @Override
    public boolean equals(java.lang.Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        BatchCardReqBody batchCardReqBody = (BatchCardReqBody) o;
        return Objects.equals(this.reward, batchCardReqBody.reward) &&
                Objects.equals(this.generateNum, batchCardReqBody.generateNum) &&
                Objects.equals(this.category, batchCardReqBody.category) &&
                Objects.equals(this.expireTime, batchCardReqBody.expireTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(reward, generateNum, category, expireTime);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("class BatchCardReqBody {\n");
        sb.append("    reward: ").append(toIndentedString(reward)).append("\n");
        sb.append("    generateNum: ").append(toIndentedString(generateNum)).append("\n");
        sb.append("    category: ").append(toIndentedString(category)).append("\n");
        sb.append("    expireTime: ").append(toIndentedString(expireTime)).append("\n");
        sb.append("}");
        return sb.toString();
    }

    /**
     * Convert the given object to string with each line indented by 4 spaces
     * (except the first line).
     */
    private String toIndentedString(java.lang.Object o) {
        if (o == null) {
            return "null";
        }
        return o.toString().replace("\n", "\n    ");
    }
}

