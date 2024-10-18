package com.easygpt.common.core.validation;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Documented
@Constraint(validatedBy = InEnumValidator.class)
@Target({ ElementType.FIELD, ElementType.PARAMETER,ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface InEnum {

    /**
     * 枚举类
     */
    Class<? extends Enum<?>> value();

    /**
     * 错误消息
     */
    String message() default "枚举值不合法";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}