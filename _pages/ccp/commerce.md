---
title: Commerce
---
The steps that can be done on Spartacus side ensure that for a standard UI flow, configurations with issues cannot be ordered. Still it's needed to also block the creation of orders via OCC, otherwise an order containing such configurations can be created using e.g. the developer tools in the end-user's browser.

In your spring configuration, see that bean commerceWebServicesCartService refers to cartValidationStrategy instead of cartValidationWithoutCartAlteringStrategy. This can be e.g. achieved like this in a custom extension's spring.xml:

```
<alias name="customWebServicesCartService" alias="commerceWebServicesCartService"/>
<bean id="customWebServicesCartService" parent="defaultCommerceCartService">
    <property name="cartValidationStrategy" ref="cartValidationStrategy"/>
    <property name="productConfigurationStrategy" ref="productConfigurationStrategy"/>
</bean>
```

Note that is will guarantee that the order is validated for product configuration issues before order submit, it will not ensure that the error message that is returned reflects the actual issue. The error message will state that the issue is because of low stock. We plan to address this in commerce release 20.11.