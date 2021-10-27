---
title: Command and Queries
---

Command and Queries are used in Spartacus to provide robust and simplified way to handle (load and cache) state and execute actions against backend system. It's similar to the way libraries like [React Query](https://react-query.tanstack.com/) and [SWR](https://swr.vercel.app/) approach the problem of handling the state coming from the API in SPA. Huge part of the frontend application state comes from the backend. Redux architecture often used for state management was not created with this type of state in mind and requires a lot of boilerplate to support it. Different types of state requires different solutions and Commands and Queries are designed to handle state coming from API in Spartacus. In a lot of cases it will replace NgRx for default Spartacus libraries and will make most implementations simpler, with better, more consistent error handling and leveraging Spartacus Events framework.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Commands overview

Commands represent an action that can change state of the system, usually by issuing rest call to the backend. Commands can return the result, and can be executed taking into consideration execution strategy.
Each command execution returns an observable, which will emit (with optional success result) and complete, when command will finish and error when command execution will result in error.

Subscribing to the result observable doesn't determine command execution, so it's optional.

## Command definition

Command can be defined as a property of a class, by storing the result of `CommandService.create` factory method call.
Parameters are:

- function that dispatches the command (usually call to the connector)
- options object (usually to specify strategy)

```typescript
  protected updateCommand: Command<{ details: User }> = this.command.create(
    (payload) =>
      this.userIdService.takeUserId(true).pipe(
        switchMap((uid) =>
          this.userProfileConnector.update(uid, payload.details)
      ),
    {
      strategy: CommandStrategy.Queue,
    }
  );
```

Available strategies are:

- Parallel: will execute all commands in parallel
- Queue: will queue commands, and execute them in order (this is a default strategy)
- CancelPrevious: will start new execution of the command and cancel previous one if not finished (result stream for previous execution will complete without emission)
- ErrorPrevious: will start new execution of the command and error previous one if not finished (result stream for previous execution will throw an error)

## Exposing command in facade services

Commands are meant to be exposed as methods, that calls execute on the command class, and returns result observable. As mentioned earlier, called can just call method to execute command. Subscribing to the result is optional.

```typescript
  update(details: User): Observable<unknown> {
    return this.updateCommand.execute({ details });
  }
```

## Query overview

Query exposes some state of the system, usually by fetching it from the backend, caching for future use and keeping it fresh by reloading it when needed.
Each query exposes loading flags as part of the data stream.

Load of the data is automatically triggered by first subscriber to the query.

## Query definition

Query can be defined as a property of a class, by storing the result of `QueryService.create` factory method call.
Parameters are:

- function that returns value of the query (usually call to the connector)
- options object (usually to specify reload and reset triggers)

```typescript
  protected titleQuery: Query<Title[]> = this.query.create(
    () => this.userProfileConnector.getTitles(),
    {
      reloadOn: [LanguageSetEvent],
    }
  );
```

`reloadOn` and `resetOn` triggers accepts events or Observable streams. Each emission of such an observable will trigger data reload (for `reloadOn` triggers) or data reset (for `resetOn` triggers). Main difference between `reload` and `reset` is, that the latter will clear the query state immediately, while `reload` will just update it, when new data will be loaded.

Good use case for `reload` trigger are language and currency change events. In this scenario you would most likely want to update all language/currency dependent content as soon as these events occur, but without introducing layout flickering and showing loaders. With `reload` trigger queries will be reloaded after language/currency change in the background, while still showing current values. When you get new response from the API in correct language the UI will be updated with new values providing smooth user experience.

On the other hand `reset` triggers are great way to react to events that potentially introduces significant changes in the backend state. One example would be `OrderPlacedEvent`. This event basically means that the current cart was ordered and now the cart is empty. In this case as soon as this event happens the current cart state is no longer seems valid, so it's safer to reset it to `undefined` value and load the cart data again with updated API state (most likely empty cart). Additionally we can react to state reset by show loading indicator on cart component, while we wait for the API response.

## Exposing query in facade services

Queries can either expose only value as an observable;

```typescript
  getTitles(): Observable<Title[]> {
    return this.titleQuery.get();
  }
```

or the whole state, with loading and error flags included:

```typescript
  getTitlesState(): Observable<QueryState<Title[]>> {
    return this.titleQuery.getState();
  }
```
