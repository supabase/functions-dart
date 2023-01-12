## [1.0.2]

- fix: add `await functions.dispose()` method to dispose yet_another_json_isolate instance

## [1.0.1]

- fix: use yet_another_json_isolate for json encoding/decoding

## [1.0.0]

- chore: v1.0.0 release 🚀
- BREAKING: set minimum SDK version to 2.15.0

## [1.0.0-dev.4]

- fix: Support null body when invoking functions

## [1.0.0-dev.3]

- BREAKING: `error` is now thrown instead of being returned within a response
```dart
try {
  final res = await functions.invoke('myFunction');
  print(res.data);
} catch (error, stacktrace) {
  print('$error \n $stracktrace');
}
```

## [1.0.0-dev.2]

- feat: use isolates for json encoding/decoding

## [1.0.0-dev.1]

- chore: Update lints to v2.0.0

## [0.0.1-dev.5]

- fix: Change the minimul SDK version to 2.12.0

## [0.0.1-dev.4]

- fix: Fix a bug where json is not properly encoded.
- fix: Set default headers with X-Client-Info.

## [0.0.1-dev.3]

- BREAKIMG: 'body', 'headers', and `responseType` are now named parameters of `invoke()`.

## [0.0.1-dev.2]

- BREAKIMG: `functionsUrl` and `headers` are now positional arguments.

## [0.0.1-dev.1]

- Initial pre-release.
