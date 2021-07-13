---
title: Skeleton Design
feature:
- name: Skeleton Design
  spa_version: 3.0
  cx_version: n/a
---

{% capture version_note %}
{{ site.version_note_part1 }} 3.0 {{ site.version_note_part2 }}
{% endcapture %}

{% include docs/feature_version.html content=version_note %}

Skeleton design, also known as ghost design, is a user experience technique that renders gray boxes on a page while the user is waiting for the real content to be loaded. This technique improves the sense of performance, and also avoids potential flickering of the UI. It often comes with an animation.

Spartacus makes use of skeleton design only in a limited number of spaces. The skeleton design feature is fully compatible with other UX patterns, such as responsive design, theming, directionality, and so on.

Skeleton design might make traditional progress bars obsolete, although the two can coexist. Spartacus has not changed the progress bar loader, and there is no plan to remove it.

The following are some of the requirements that were taken into account while this feature was being developed:

- Skeleton design should work on top of existing UX patterns, such as responsive design, theming, directionality, and so on.
- Multiple skeletons should be able to run in parallel.
- The animation should often include multiple elements, which means that a single animation goes from the left to the right of the outer element.
- If multiple skeletons are on the same page, it should be possible to have multiple skeleton animations.
- The animation should always go from left to right, even on a right-to-left oriented site.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## Rendering Skeleton Designs

There are various techniques that you can use to render skeleton designs, such as the following:

- using an image (svg) to render a skeleton while loading the content
- using an special skeleton component to render a skeleton for a specific component
- using CSS to render a skeleton for an existing component

Introducing specific skeleton images or components has various disadvantages. They can cause problems for the implementation and the performance, and they do not cope with other UX patterns. However, using a pure CSS solution on an existing component will work with all existing UX patterns, and will not add more complexity or performance drawbacks. This is done with the following techniques:

- A `ghost` CSS class is added to the root element of the specific skeleton. If you use multiple isolated skeletons on a single page, those can work independently. Each `ghost` has its own skeleton animation.
- The existing component DOM is used for the skeleton elements. No special DOM or specific ghost elements are introduced to build the skeletons.
- The content stream (or streams) must be started with a ghost data set. Data streams in Spartacus are based on RxJS, which you can combine with a `startWith` operator. The `startWith` operator typically has an array of empty objects, and potential other elements, to mimic the data.
- The component implementation should be prepared for empty elements. This is a good practice anyway, but might not be the case for existing components.

## Example

An example of skeleton design can be found in the organization feature. Most entities in the organization self-service are based on lists of items that can be managed by the user. These lists are implemented with the following techniques, which leverage the skeleton design feature in Spartacus:

- using a ghost data set to mimic the list data
- adding the ghost CSS class to apply default skeleton styles
- adding bespoke CSS rules for specifics to the organization list skeleton layout

Standard CSS is then used to add the gray boxes with an animation.

The first two of these techniques are described in the following sections.

### Starting with Ghost Data

The data stream uses the `startWith` operator to obtain an initial ghost data set, as shown in the following example:

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

In this case, the initial data set has an array of 10 list items, which are used to mimic the final data. The final data might have a larger or smaller list, and likely will introduce pagination, but for the skeleton, we only want to show the skeleton list.

### Adding the `ghost` Class to the Outer Element

There are various techniques to add the `ghost` class. For example, you can add the class and validate if the data is indeed the ghost data, as follows:

```ts
@HostBinding('class.ghost') hasGhostData = false;

data$ = this.service.getData().pipe(
    tap((data) => {
        // verify if the emitted data is a ghost
        this.hasGhostData = this.service.hasGhostData(data);
    })
)
```
