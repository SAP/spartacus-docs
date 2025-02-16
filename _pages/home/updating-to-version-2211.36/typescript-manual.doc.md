---
title: Technical Changes in Spartacus 2211.36
---

## Changes in the Feature Library Order

In `MyAccountV2OrderHistoryService`, the `getOrderDetails` method has been removed. Instead, use `getOrderDetailsV2` directly.

## Changes in the Product Configurator Feature Library

### Removal of the Deprecated and Obsolete CPQ Connection Scenario

Until this release, the CPQ integration foresaw a CPQ orchestration flavor where the storefront performed direct calls to CPQ for configuration read and change. This flavor is no longer supported from the CPQ side, and is has been deprecated since release 2211.25.

The flavor had been activated by switching the `productConfigurator.cpqOverOcc` configuration setting to `false`. This attribute has been removed, and all entities that supported the flavor have been deleted as well.

Now the storefront only provides the orchestration flavor where all calls to CPQ are routed through the Commerce back end, meaning all calls are done through OCC.

## Removal of the Obsolete 'enableNavigationToConflict' Configuration Setting

Until this release, the navigation to a conflict group from a conflicting attribute could be disabled using the `productConfigurator.enableNavigationToConflict` configurator setting. This setting was necessary when working with a Commerce back end that was older than release 2205. Now that versions of SAP Commerce older than 2205 are out of maintenance, the configuration setting has been removed.

If you are still running an out-of-maintenance version of SAP Commerce (2105 or older), consider adjusting `ConfiguratorAttributeHeaderComponent` and always return `false` for the `isNavigationToConflictEnabled` method.

## Removal of Deprecated Methods in the ConfigureCartEntryComponent

- `getQueryParams`: use `queryParams$` instead.
- `getOwnerType`: use `retrieveOwnerTypeFromAbstractOrderType` instead.
- `getEntityKey`: use `retrieveEntityKey` instead.

## Removal of Deprecated Methods or Attributes in ConfiguratorTabBarComponent

- `isOverviewPage$`: use `getPageType$` instead.
- `getTabIndexConfigTab`: use `getTabIndexForConfigTab` instead.
- `getTabIndexOverviewTab`: use `getTabIndexForOverviewTab` instead.

## Removal of Deprecated 'RETRACT_VALUE_CODE' Attribute in OccConfiguratorVariantSerializer

Use `Configurator.RetractValueCode`instead.

## Removal of Deprecated 'RETRACT_VALUE_CODE' Attribute in OccConfiguratorVariantNormalizer

Use `Configurator.RetractValueCode`instead.
