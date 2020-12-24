Useful utils for [gist.cafe](https://gist.cafe) Dart Apps.

## Usage

Simple usage example:

```dart
import 'package:gistcafe/gistcafe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  final orgName = 'dart-lang';

  Iterable json = jsonDecode(
      (await http.get('https://api.github.com/orgs/${orgName}/repos')).body);

  final orgRepos = json.map((e) => GithubRepo.fromJson(e)).toList();
  orgRepos.sort((a, b) => b.watchers - a.watchers);

  print("Top 3 '${orgName}' Github Repos:");
  Inspect.printDump(orgRepos.take(3));

  print("\nTop 10 '${orgName}' Github Repos:");
  Inspect.printDumpTable(orgRepos.take(10));

  Inspect.vars({'orgRepos': orgRepos});
}
```

Which outputs:

```
Top 3 'dart-lang' Github Repos:
[
    {
        name: stagehand,
        description: Dart project generator - web, console apps,
        lang: Dart,
        watchers: 634,
        forks: 121
    },
    {
        name: dart-vim-plugin,
        description: Syntax highlighting for Dart in Vim,
        lang: Vim script,
        watchers: 480,
        forks: 42
    },
    {
        name: dart_style,
        description: An opinionated formatter/linter for Dart code,
        lang: Dart,
        watchers: 473,
        forks: 64
    }
]

Top 10 'dart-lang' Github Repos:
.--------------------------------------------------------------------------------------------------------.
|          name          |                 description                   |    lang    | watchers | forks |
|--------------------------------------------------------------------------------------------------------|
| stagehand              | Dart project generator - web, console apps    | Dart       |      634 |   121 |
| dart-vim-plugin        | Syntax highlighting for Dart in Vim           | Vim script |      480 |    42 |
| dart_style             | An opinionated formatter/linter for Dart code | Dart       |      473 |    64 |
| mockito                | Mockito-inspired mock library for Dart        | Dart       |      346 |    72 |
| protobuf               | Runtime library for Dart protobufs            | Dart       |      281 |   113 |
| intl                   | Internationalization and localization support | Dart       |      278 |    93 |
| dartdoc                | API documentation tool for Dart.              | Dart       |      263 |    68 |
| markdown               | A Dart markdown library                       | Dart       |      231 |    85 |
| dart-tutorials-samples | Sample code for "A Game of Darts" tutorial    | Dart       |      181 |   195 |
| googleapis             | Repository for building googleapis packages   | Dart       |      176 |    55 |
'--------------------------------------------------------------------------------------------------------'
```

Whilst `Inspect.vars()` lets you view variables in [gist.cafe](https://gist.cafe) viewer:

![](https://raw.githubusercontent.com/ServiceStack/gist-cafe/main/docs/images/vars-orgRepos-dart-lang.png)

View and execute Dart gists with [gist.cafe](https://gist.cafe), e.g: [gist.cafe/47e4cce5306ec4bfcc073065cbbbf60c](https://gist.cafe/47e4cce5306ec4bfcc073065cbbbf60c).

### Limitations

All objects in `Inspect` APIs need to be [json encodable](https://flutter.dev/docs/development/data-and-backend/json#serializing-json-inside-model-classes).

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/ServiceStack/gistcafe-dart/issues).