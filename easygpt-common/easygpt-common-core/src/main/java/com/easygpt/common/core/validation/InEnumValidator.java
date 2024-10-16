package com.easygpt.common.core.validation;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Arrays;

public class InEnumValidator implements ConstraintValidator<InEnum, Integer> {

    private Class<? extends Enum<?>> enumClass;

    @Override
    public void initialize(InEnum annotation) {
        this.enumClass = annotation.value();
    }

    @Override
    public boolean isValid(Integer value, ConstraintValidatorContext context) {
        if (value == null) {
            return true;  // 可以在这里修改为 false，如果不允许为空
        }

        // 检查枚举中是否存在该值
        return Arrays.stream(enumClass.getEnumConstants())
                .anyMatch(e -> value.equals(((Enum<?>) e).ordinal()));
    }
}