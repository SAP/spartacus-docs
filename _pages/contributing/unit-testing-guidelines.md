---
title: Unit Testing Guidelines
---

The following are some best practices for writing Spartacus unit tests.

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
{:toc}

***

## General Guidelines

- All code must be covered by unit tests.
- Test one thing per test (it).
- Unit tests isolate the tested code from it's dependencies: mock all the dependencies you can.
- Unit tests need to be independent from one another: we should be able to run the tests from a file in any order and it would not change the outcome.
- Cover happy path, errors, edge cases and UI when applicable.

## UI Components

### Mock Everything

Mock everything. As with any other piece of code, we want to test the UI component in isolation. We don't want the test results to be influenced by code that is outside of the class we are testing.

While mocking dependencies like services is more obvious, it's easy to forget to mock subcomponents that are called from within the tested component's template.

To mock a subcomponent, you create a fake copy of it in your spec file. The fake component must have the same selector as the subcomponents you want to fake:

```typescript
@Component({
  template: '',
  selector: 'cx-some-component'
})
class MockSomeComponent {
  @Input() someparam;
}
```

Then, you declare it in the TestBed:

```typescript
TestBed.configureTestingModule({
    imports: [
        ...
    ],
    declarations: [MockSomeComponent],
    providers: [
        ...
    ],
}).compileComponents();
```

### Covering the UI

For UI components, create tests that read and interact with the UI, not just the component class functions. Writing UI tests in the component unit tests is inexpensive compared to e2e tests. Again, cover the main scenarios and also error scenarios and edge cases that have an impact on the UI.

## NGRX and Tests That Use the Store

Mocking the NGRX store has proven to be quite a challenge. The NGRX store is the exception to the rule of mocking dependencies in our unit tests.

To perform a unit test on a piece of code that reads from the store, populate the store by calling explicitly the relevant success actions with the data to set up the test.

Here is an example where we dispatch *LoadUserAddressesSuccess* to set up the test data:

```typescript
it('should be able to get user addresses', () => {
  const mockUserAddresses: Address[] = [{ id: 'address1' }, { id: 'address2' }];
  store.dispatch(new UserActions.LoadUserAddressesSuccess(mockUserAddresses));

  let addresses: Address[];
  service
    .getAddresses()
    .subscribe(data => {
      addresses = data;
    })
    .unsubscribe();
  expect(addresses).toEqual([{ id: 'address1' }, { id: 'address2' }]);
});
```

## Using Test Grouping for Improved Readability

```typescript
Use the *describe* block to logically group related tests:

  describe('addNumbers function', () => {
    it('should properly add 2 and 2', () => {
        ...
    });
    it('should support negative numbers', () => {
        ...
    });
    it('should not accept decimal numbers', () => {
        ...
    });
  });
```

## Avoiding Silently Failing Tests

### Assert Outside a Subscription

It is a best practice to remove assertions outside of subscriptions. This way, we make sure that the assertion is executed before the test finishes. To assert the result of an observable, we assign the result in the subscription, but the assertion is done after, outside the subscription with the value. For example:

Instead of this:

```typescript
    service
      .getAddresses()
      .subscribe(addresses => {
        expect(addresses).toEqual([{ id: 'address1' }, { id: 'address2' }]);
      })
      .unsubscribe();

  });
```

Do this instead:

```typescript
    let addresses: Address[];
    service
      .getAddresses()
      .subscribe(data => {
        addresses = data;
      })
      .unsubscribe();
    expect(addresses).toEqual([{ id: 'address1' }, { id: 'address2' }]);
  });
```

### Initializing the Result with a Value That Fails the Assertion

Avoid initializing a result variable to a value that would pass with success if nothing were to happen between the declaration and the assertion. For example:

```typescript
let result: boolean;
service
  .hasPage('home')
  .subscribe(value => (result = value))
  .unsubscribe();

expect(result).toBeFalsy();
```

In the above example, the assertion will be true even if the `hasPage` function is never called (or does nothing). Instead, initialize the result variable to a value that will fail the assertions. This way, we can be sure the action we are testing performed some processing.

In the example below, the value *true* will fail the assertion unless the process is called and provides the expected falsy result.

```typescript
let result = true;
service
  .hasPage(home)
  .subscribe(value => (result = value))
  .unsubscribe();

expect(result).toBeFalsy();
```
