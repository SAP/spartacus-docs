---
title: FSA Coupons
---

**Note**: This feature is introduced with version 3.0 of the FSA Spartacus libraries.

The Coupons feature allows financial customers to apply coupons during the quotation process and to obtain a discount. Coupons can be applied to both insurance and banking products. Customers can view their coupons in the **My Coupons** section of the **My Account** area.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Requirements

The following extension is required to enable coupons in FSA Spartacus:

```xml
<extension name="customercouponocc" />
```

To be able to configure coupons in the Backoffice, you will also need the following two extensions: 

```xml
<extension name="customercouponbackoffice" />
<extension name="couponbackoffice" />    
```

## Enabling Coupons

Coupons in FSA Spartacus make use of the [Coupons]({{ site.baseurl }}{% link _pages/dev/features/coupons.md %}) and [Customer Coupons]({{ site.baseurl }}{% link _pages/dev/features/customer-coupons.md %}) features implemented in the core Commerce Spartacus. Coupons must be activated and their corresponding promotion rules must be published in the Backoffice before they can be applied in the storefront. See [Coupon Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/d35c247bac2d4c91a6ca4501b63cb2b4.html) for more details. 

Coupons are managed in the Backoffice. FSA Spartacus allows for the creation of single-code, multi-code, and customer coupons through Backoffice.  

Once a customer coupon is created, it needs to be assigned to a customer. The customer can then preview the coupon in the **My Coupons** section of the **My Account** area.

![My Coupons]({{ site.baseurl }}/assets/images/fsa/my_coupons.png)

## Coupon Promotion

When you create a coupon code, you must also create a **promotion rule** that defines the discount that customers receive when they redeem the coupon. This can also be done through Backoffice. For more information, see [Coupon Promotions](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/df904660eed2407db94dc8b52b17ad2d.html) in the SAP Help Portal. 

After a coupon promotion has been created, customers apply the applicable coupon to activate the promotion during checkout to get discounts and/or rewards for their orders.

In the following example, a sample single-code coupon FSA10DICS has been applied to the customer's mini cart during the Auto Insurance product checkout process.

**Cart before the coupon has been applied**

Customers apply their coupon during checkout by entering the code in the corresponding field on the **Add Options** page.

![Applying coupon code]({{ site.baseurl }}/assets/images/fsa/applying_coupon_code.png)

**Cart after the coupon has been applied**

Once the coupon code is applied, the discount is calculated to the cart. An appropriate toast message is displayed to the customer and the information about the saved amount is visible in the cart.

![Coupon code applied to the cart]({{ site.baseurl }}/assets/images/fsa/coupon_code_applied.png)

After the checkout is completed and the order placed, customers can see the amount they saved and which coupons were applied to the order on the **Order Details** page. 

![Reduced price on Order Details page]({{ site.baseurl }}/assets/images/fsa/coupons_order_history.png)

## Further Reading

- [Coupon Module](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/d35c247bac2d4c91a6ca4501b63cb2b4.html)
- [Customer Coupon Management](https://help.sap.com/viewer/4c33bf189ab9409e84e589295c36d96e/latest/en-US/b307666c232146058353c1f6e8a058fd.html)
- [Coupon Promotions](https://help.sap.com/viewer/9d346683b0084da2938be8a285c0c27a/latest/en-US/df904660eed2407db94dc8b52b17ad2d.html)
