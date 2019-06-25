For the following steps, the Electronics sample site is used along with the Spartacus Sample Data Addon.

#### 1. Backend Extension Requirements

Make sure all the required personalization extensions and adding are installed into your SAP Commerce Cloud instance. For more information, see the [Personalization installation instructions](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/1905/en-US/6a0dae49ef2c4fe3b475084079cb7360.html) for your release.

#### 2. Backend CORS Settings

As described in [this help document](https://help.sap.com/viewer/86dd1373053a4c2da8f9885cc9fbe55d/1905/en-US/e970070f997041c7b3f3e77fcb762744.html), add `occ-personalization-id` and `occ-personalization-time` to the following settings:

- `corsfilter.ycommercewebservices.allowedHeaders`
- `corsfilter.ycommercewebservices.exposedHeaders`

If a setting doesn't exist, create it.

If the setting already exists, add the new values to the end, including a space before. For example, `allowedHeaders` might look like this:

```
origin content-type accept authorization occ-personalization-id occ-personalization-time
```

Note: You can edit these settings using the HAC, but you can also add these parameters to `local.properties` in the `hybris/config` folder or in ycommercewebservices'  `project.properties` file.

#### 3. Personalization configuration in Backoffice

1. In Backoffice, go to Personalization > Configuration > Personalization Configuration.

2. Select **Electronics Site**.

3. In the Properties tab, General section, add **Spartacus Electronics Site** to **Set of base sites**.

4. In the Commerce Web Services tab, set **Personalization for Commerce Web Services** to **True**.

  To test that the configuration is working:

  - Send an OCC REST API call to your site. You should see `Occ-Personalization-Id` in the response header. 
  - Send the call again but with `Occ-Personalization-Id: yourid` in the header,  and you should also see `Occ-Personalization-Time`.

#### 4. Enabling Personalization in Spartacus

In `app.module.ts`, add the following to the settings in the section `StorefrontModule.withConfig`:

```
personalization: {
  enabled: true,
},
```

#### Testing Personalization

