---
title: Commands and Queries
feature:
  - name: Commands and Queries
    spa_version: 3.2
    cx_version: n/a
---

Commands and queries provide a robust and simplified way to handle state (in other words, loading and caching), and to execute actions against the back end system. This is similar to the way that libraries such as React Query and SWR approach the problem of handling the state coming from the API in a single page application. A large part of the front end application state comes from the back end. Redux architecture, which is often used for state management, was not created with this type of state in mind, and requires a lot of boilerplate to support it. Different types of state require different solutions, and commands and queries are designed to handle the state coming from the API in Spartacus. In a lot of cases, commands and queries will replace NgRx for default Spartacus libraries, and will make most implementations simpler, with better, more consistent error handling, while also leveraging the Spartacus events framework.

---

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

---

## Commands Overview

Commands represent an action that can change the state of the system, usually by issuing a REST call to the back end. Commands can return a result, and can be executed while taking an execution strategy into consideration. Each command execution returns an observable, which emits (with an optional success result) and then completes when the command finishes, or throws an error when the command execution results in an error.

Subscribing to the result observable does not determine command execution, so it is optional.

## Command Definition

A command can be defined as a property of a class by storing the result of the `CommandService.create` factory method call.

Commands have the following parameters:

- a function that dispatches the command (usually a call to the connector)
- an options object (usually to specify a strategy)

The following is an example:

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

The available strategies are the following:

- `Parallel` executes all commands in parallel.
- `Queue` queues commands and executes them in order (this is the default strategy).
- `CancelPrevious` starts a new execution of the command and cancels the previous one if it has not finished (the result stream for the previous execution will complete without emission).
- `ErrorPrevious` starts a new execution of the command and throws an error for the previous one if it has not finished (the result stream for the previous execution will throw an error).

## Exposing Commands in Facade Services

Commands are meant to be exposed as methods that calls can execute on the command class, and that return a result observable. As mentioned earlier, the call can simply invoke a method to execute the command. Subscribing to the result is optional. The following is an example:

```typescript
  update(details: User): Observable<unknown> {
    return this.updateCommand.execute({ details });
  }
```

## Queries Overview

Queries expose some state of the system, usually by fetching it from the back end, caching it for future use, and keeping it fresh by reloading it when needed. Each query exposes loading flags as part of the data stream.

Loading of the data is automatically triggered by the first subscriber to the query.

## Query Definition

A query can be defined as a property of a class by storing the result of the `QueryService.create` factory method call.

Queries have the following parameters:

- a function that returns the value of the query (usually a call to the connector)
- an options object (usually to specify triggers for reloading and resetting)

The following is an example:

```typescript
  protected titleQuery: Query<Title[]> = this.query.create(
    () => this.userProfileConnector.getTitles(),
    {
      reloadOn: [LanguageSetEvent],
    }
  );
```

The `reloadOn` and `resetOn` triggers accept events or `Observable` streams. Each emission of this kind of observable triggers a data reload (for `reloadOn` triggers) or a data reset (for `resetOn` triggers). The main difference between `reload` and `reset` is that `reset` clears the query state immediately, while `reload` just updates it when new data is loaded.

A good use case for the `reload` trigger is with language and currency change events. In this scenario, you would most likely want to update all language or currency dependent content as soon as these events occur, but without introducing layout flickering, and without showing loaders. With the `reload` trigger, queries are reloaded in the background after the language or currency change, while still showing current values. When you get a new response from the API in the correct language, the UI is updated with the new values, thereby providing a smooth user experience.

On the other hand, `reset` triggers are a great way to react to events that potentially introduce significant changes in the back end state. One example would be with the `OrderPlacedEvent`, which is an event that indicates that the current cart was ordered, and that now it is empty. In this case, as soon as the `OrderPlacedEvent` event happens, the current cart state no longer seems valid, so it is safer to reset it to the value `undefined`, and load the cart data again with an updated API state (which would most likely be an empty cart). Additionally, Spartacus can react to a state reset by showing a loading indicator on the cart component, while the app waits for the API response.

## Exposing Queries in Facade Services

Queries can either expose a single value as an observable, or they can expose the entire state, including loading and error flags.

The following is an example of a query that exposes a single value as an observable:

```typescript
  getTitles(): Observable<Title[]> {
    return this.titleQuery.get();
  }
```

The following is an example of a query that exposes the entire state, with loading and error flags included:

```typescript
  getTitlesState(): Observable<QueryState<Title[]>> {
    return this.titleQuery.getState();
  }
```
