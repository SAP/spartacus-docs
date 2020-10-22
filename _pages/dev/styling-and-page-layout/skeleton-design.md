# Skeleton Design

Skeleton Design, also known as _ghost design_, is an experience design technique that renders gray boxes while the user is waiting for the actual content to be loaded. This technique improves the sense of performance, and avoids annoying flickering of the UI. It often comes with an animation.

Skeleton design overlaps with loader indicators, although the two can coexist.

Spartacus introduced Skeleton Design with version 3.0, but it is only used in a limited number of spaces. The Skeleton Design feature is fully compatible with other UX patterns, such as responsive design, theming, directionality, etc.

## Technique

There are various techniques that you could use to render skeleton design:

1. use an image (svg) to render a skeleton while loading the content
2. use an special skeleton component to render a skeleton for a specific component
3. use CSS to render a skeleton for an existing component

Introducing specific skeleton images (1) or components (2) have various disadvantages. It will trouble the implementation and performance and would not be able to cope with other ux patterns. The 3rd option, using a pure CSS solution on existing component, is able to coop with all existing ux patterns and will not introduce more complexity or performance drawbacks. This is done with the following techniques:

- A `ghost` css class is added to the root element of the specific skeleton; If you use multiple isolated skeletons on a single page, those can work independently. Each `ghost` has its own skeleton animation.
- The existing component DOM is used for the skeleton elements; there are no specific _ghost_ elements or DOM introduced to build the skeletons.
- The content stream(s) must be started with a ghost data set. Data streams in Spartacus are based on RxJS, which as a `startWith` operator. The `startWith` operator would typically have an array of empty objects and potential other elements, to mimic the data.
- The component implementation should be prepared for empty elements. This is a good practice anyway, but might not be the case for existing components.

## Example

An example of skeleton design can be found in the new organization feature that is introduced with Spartacus 3.0. Most entities in the organization self service are based on a list of items that can be administrated by the user. These lists use skeletons, using two techniques (See below). A standard CSS is used to add the gray boxes with an animation.

### Start with ghost data

The data stream uses the `startWith` operator to have an initial ghost data set. The initial data set (in this case) has an array of 10 list items, that will be used to mimic the final data. The final data might have a larger or smaller list, and likely will introduce pagination, but for the skeleton we only want to show the skeleton list.

```ts
// ghost data to build an initial skeleton of the final data
protected ghostData = { values: new Array(10) };

getData(): Observable<T> {
    return this.service.getData().pipe(
        // start with the ghost data
        startWith(this.ghostData)
    );
}
```

### Add the `ghost` class to the outer element

There are various techniques to add the `ghost` class. The example below shows adding the glass and validating if the data is indeed the ghost data.

```ts
@HostBinding('class.ghost') hasGhostData = false;

data$ = this.service.getData().pipe(
    tap((data) => {
        // verify if the emitted data is a ghost
        this.hasGhostData = this.service.hasGhostData(data);
    })
)
```
