---
title: Deprecation of Calydon Theme
---

The nature of the changes done in order to set the calydon-theme as the base-theme were the following:

1. For all visual changes fixed during the calydon theme alternance (before 2.0), it's no longer needed to uncomment this line `$theme: 'calydon';` in this file `/storefrontapp/src/styles.scss` as we did before for the changes to show up, all of them are now default in the base theme.

2. The calydon theme and its instances have been deprecated, but the structure for an alternate theme remains in place in order to be renamed after the 2.0 release. New name or number still to be discussed (tbd).

    | Calydon theme | Replacement |
    | -------------- | ----------- |
    | /storefrontstyles/scss/themes/calydon |  /storefrontstyles/scss/themes/`tbd`  |

3. All calydon instances under the following sub-directories were deleted:

    ```
    /storefrontstyles/scss/themes/calydon/components
    /storefrontstyles/scss/themes/calydon/layout
    ```

4. Here's a list of the deleted calydon instances and the location where they are to be found now, in the base theme.

    | Calydon Theme (deleted)                                                                         | Base Theme                                                                      |
| ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| /scss/themes/calydon/components/cart/\_cart-details.scss                                        | /scss/components/cart/\_cart-details.scss                                       |
| /scss/themes/calydon/components/cart/\_cart-item-list.scss                                      | /scss/components/cart/\_cart-item-list.scss                                     |
| /scss/themes/calydon/components/cart/\_cart-item.scss                                           | /scss/components/cart/\_cart-item.scss                                          |
| /scss/themes/calydon/components/cart/\_cart-totals.scss                                         | /scss/components/cart/\_cart-totals.scss                                        |
| **/scss/themes/calydon/components/content/navigation/\_navigation-ui.scss**                         | /scss/components/content/navigation/\_navigation-ui.scss                        |
| /scss//themes/calydon/components/content/tab-paragraph-container/\_tab-paragraph-container.scss | /scss/components/content/tab-paragraph-container/\_tab-paragraph-container.scss |
| /scss/themes/calydon/components/myaccount/\_consignment-tracking.scss                           | /scss/components/myaccount/order-details/\_consignment-tracking.scss            |
| /scss/themes/calydon/components/myaccount/\_order-history.scss                                  | /scss/components/myaccount/order-history/\_order-history.scss                   |
| /scss/themes/calydon/components/myaccount/\_order-return-request-list.scss                      | /scss/components/myaccount/order-history/\_order-return-request-list.scss       |
| **/scss/themes/calydon/components/myaccount/\_update-password.scss**                                | /scss/components/myaccount/\_forgot-password.scss                               |
| /scss/themes/calydon/components/product/carousel/\_product-carousel.scss                        | /scss/components/product/carousel/\_product-carousel.scss                       |
| /scss/themes/calydon/components/product/details/\_product-images.scss                           | /scss/components/product/details/\_product-images.scss                          |
| /scss/themes/calydon/components/product/list/\_product-grid-item.scss                           | /scss/components/product/list/\_product-grid-item.scss                          |
| /scss/themes/calydon/components/product/list/\_product-list-item.scss                           | /scss/components/product/list/\_product-list-item.scss                          |
| /scss/themes/calydon/components/product/list/\_product-list.scss                                | /scss/components/product/list/\_product-list.scss                               |
| /scss/themes/calydon/components/product/search/\_searchbox.scss                                 | /scss/components/product/search/\_searchbox.scss                                |
| /scss/themes/calydon/components/product/\_product-view.scss                                     | /scss/components/product/list/\_product-view.scss                               |
| /scss/themes/calydon/layout/header/\_header.scss                                                | /scss/components/layout/header/\_header.scss                                    |
| /scss/themes/calydon/layout/page-templates/\_category-page.scss                                 | /scss/layout/page-templates/\_category-page.scss                                |
| /scss/themes/calydon/layout/page-templates/\_landing-page-2.scss                                | /scss/layout/page-templates/\_landing-page-2.scss                               |
| /scss/themes/calydon/layout/page-templates/\_product-detail.scss                                | /scss/layout/page-templates/\_product-detail.scss                               |
| **none**                                                                                            | /scss/layout/\_page-fold.scss                                                   |
| **none**                                                                                            | /scss/cxbase/blocks/buttons.scss                                                |
| **none**                                                                                            | /scss/cxbase/blocks/forms.scss                                                  |


5. It's worth noting that some files (**bold** in the table) had different  approaches, for example:

- Base theme file `navigation-ui.scss` had conditional statements within the base file, that were unwrapped to make the default, as well as a calydon instance that was transferred.
- Contents of calydon's instance for `update-password.scss` were transferred into base theme file `forgot-password.scss` (different file name) since the code fix length was extremely short for creating an individual file.
- The following files didn't have a calydon instance, only conditional statement, therefore by unwrapping the calydon conditions within the file they became default code.

    ```
    /storefrontstyles/scss/layout/_page-fold.scss
    /storefrontstyles/scss/cxbase/blocks/buttons.scss
    /storefrontstyles/scss/cxbase/blocks/forms.scss
    ```
