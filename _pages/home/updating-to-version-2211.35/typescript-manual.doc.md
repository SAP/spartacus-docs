---
title: Technical Changes in Spartacus 2211.36
---

The following sections list technical changes that have been made to the Order feature library and the Product Configurator feature library in Spartacus 2211.36.

## Changes in the Order Feature Library

In `MyAccountV2OrderHistoryService`, the `getOrderDetails` method has been removed. Instead, use `getOrderDetailsV2` directly.

## Changes in the Product Configurator Feature Library

### Removal of the Deprecated and Obsolete CPQ Connection Scenario

Until this release, the CPQ integration foresaw a CPQ orchestration flavor where the storefront performed direct calls to CPQ for configuration read and change. This flavor is no longer supported from the CPQ side, and is has been deprecated since release 2211.25.

The flavor had been activated by switching the `productConfigurator.cpqOverOcc` configuration setting to `false`. This attribute has been removed, and all entities that supported the flavor have been deleted as well.

Now the storefront only provides the orchestration flavor where all calls to CPQ are routed through the Commerce back end, meaning all calls are done through OCC.

### Removal of Obsolete Configuration Setting

Until this release, the navigation to a conflict group from a conflicting attribute could be disabled using the `productConfigurator.enableNavigationToConflict` configurator setting. This setting was necessary when working with a Commerce back end that was older than release 2205. Now that versions of SAP Commerce older than 2205 are out of maintenance, the configuration setting has been removed.

If you are still running an out-of-maintenance version of SAP Commerce (2105 or older), consider adjusting `ConfiguratorAttributeHeaderComponent` and always return `false` for the `isNavigationToConflictEnabled` method.

### Additional Changes

The following deprecated methods have been removed from the `ConfigureCartEntryComponent`:

- `getQueryParams` has been removed. Use `queryParams$` instead.
- `getOwnerType` has been removed. Use `retrieveOwnerTypeFromAbstractOrderType` instead.
- `getEntityKey` has been removed. Use `retrieveEntityKey` instead.

The following deprecation methods or attributes have been removed from the `ConfiguratorTabBarComponent`:

- `isOverviewPage$` has been removed. Use `getPageType$` instead.
- `getTabIndexConfigTab` has been removed. Use `getTabIndexForConfigTab` instead.
- `getTabIndexOverviewTab` has been removed. Use `getTabIndexForOverviewTab` instead.

The deprecated `RETRACT_VALUE_CODE` attribute in `OccConfiguratorVariantSerializerUse` has been removed. Use `Configurator.RetractValueCode` instead.

The deprecated `RETRACT_VALUE_CODE` attribute in `OccConfiguratorVariantNormalizer` has been removed. Use `Configurator.RetractValueCode`instead.
