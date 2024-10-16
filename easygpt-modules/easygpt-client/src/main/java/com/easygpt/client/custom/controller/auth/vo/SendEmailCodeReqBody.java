package com.easygpt.client.custom.controller.auth.vo;

import com.easygpt.client.custom.enums.EmailCodeSceneEnum;
import com.easygpt.common.core.validation.InEnum;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Objects;

/**
 * GetEmailCodeReqBody
 */
@javax.annotation.Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2024-10-15T15:41:55.271058+08:00[Asia/Shanghai]")

public class SendEmailCodeReqBody {

  @JsonProperty("email")
  private String email;

  @JsonProperty("scene")
  private Integer scene;  // 场景编号

  public SendEmailCodeReqBody email(String email) {
    this.email = email;
    return this;
  }

  /**
   * 邮箱
   * @return email
   */
  @ApiModelProperty(required = true, value = "邮箱")
  @NotNull(message = "邮箱不能为空")
  @Pattern(regexp="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", message = "邮箱格式不正确")
  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public SendEmailCodeReqBody scene(Integer scene) {
    this.scene = scene;
    return this;
  }

  /**
   * 邮件场景
   * @return scene
   */
  // 使用 InEnum 验证场景编号
  @ApiModelProperty(required = true, value = "邮件场景")
  @NotNull(message = "邮件场景不能为空")
  @InEnum(value = EmailCodeSceneEnum.class, message = "邮件场景不合法")
  public Integer getScene() {
    return scene;
  }

  public void setScene(Integer scene) {
    this.scene = scene;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    SendEmailCodeReqBody that = (SendEmailCodeReqBody) o;
    return Objects.equals(this.email, that.email) &&
            Objects.equals(this.scene, that.scene);
  }

  @Override
  public int hashCode() {
    return Objects.hash(email, scene);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class SendEmailCodeReqBody {\n");
    sb.append("    email: ").append(toIndentedString(email)).append("\n");
    sb.append("    scene: ").append(toIndentedString(scene)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  private String toIndentedString(Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}