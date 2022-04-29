---
title: Extending Best Practices
---

The Spartacus library gives us great opportunities. Many Spartacus elements can be reused and some of them just need to be carefully extended in our own way.

Extending the elements should be the basic action we will perform in Spartacus implementation projects.

Each time you have to implement a new feature or a single functionality, find it or something similar in the Spartacus Code and analyse how much you can reuse.

### Extending components

In many cases, we will only need to implement the component appearance because of the designs. What we should do is to create our own component, extends it with Spartacus component and use our own template and styles. If we have to add any new method or override existing we can to it in our own component.

```
@Component({
  selector: 'custom-cart-totals',
  templateUrl: './cart-totals.component.html',
  styleUrls: ['./cart-totals.component.scss']
})
export class CustomCartTotalsComponent extends CartTotalsComponent implements OnInit {

  constructor(
    activeCartService: ActiveCartService
  ) {
    super(activeCartService)
  }

  ngOnInit(): void {
    super.ngOnInit();
    // additional action
  }

  customMethod(): void {
    // custom method
  }

  customMethodWithActiveCartService(): Observable<Cart> {
    // Custom method
    // return this.activeCartService.getActive();
  }
}
```

### Extending adapters, services, serializers, guards

If we need to extend any adapter/service/serializer/guard we should do it in a similar way to the component. Creating own custom adapter/service/serializer/guard and extending the Spartacus adapter/service/serializer/guard with our own. Additionally, we have to provide it in our module.

```
@NgModule({
  imports: [
    CommonModule
  ],
  providers: [
    {
        provide: CartAdapter,
        useClass: CustomCartAdapter,
    },
    {
        provide: ActiveCartService,
        useClass: CustomActiveCartService
    },
    {
        provide: SiteContextUrlSerializer,
        useClass: CustomSiteContextUrlSerializer,
    },
    {
        provide: AuthGuard,
        useClass: CustomAuthGuard,
    },
  ]
})
export class CustomCartTotalModule { }
```

### Extending pageMetaResolvers and normalizers

Extending Page Meta Resolvers or Normalizer looks the same as with adapters, the only difference is providing them.

```
@NgModule({
  imports: [
    CommonModule
  ],
  providers: [
    {
        provide: PageMetaResolver,
        useExisting: CustomCartPageMetaResolver,
        multi: true,
    },
    {
        provide: PRODUCT_NORMALIZER,
        useClass: CustomProductNormalizer,
        multi: true,
    },
  ]
})
export class CustomCartTotalModule { }
```