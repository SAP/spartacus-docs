---
title: Command and Queries
---

Command and Queries are used in Spartacus to provide robust and simplified way to handle (load and cache) state and execute actions against backend system. I most cases it replaces NgRx for default Spartacus libraries, as for most implementations it's simpler, offers better, more consistent error handling and can leverage Spartacus Events framework.  

***

**Table of Contents**

- This will become a table of contents (this text will be scrapped).
  {:toc}

***

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
