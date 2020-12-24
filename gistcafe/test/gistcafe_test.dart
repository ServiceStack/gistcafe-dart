import 'dart:convert';
import 'dart:io';

import 'package:gistcafe/gistcafe.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

class GithubRepo {
  final String name;
  final String description;
  final String lang;
  final int watchers;
  final int forks;

  GithubRepo(
      {this.name, this.description, this.lang, this.watchers, this.forks});

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    return GithubRepo(
        name: json['name'],
        description: json['description'],
        lang: json['language'],
        watchers: json['watchers_count'],
        forks: json['forks']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'lang': lang,
        'watchers': watchers,
        'forks': forks,
      };
}

void main() {
  group('A group of tests', () {
    setUp(() {});

    test('Can dump objects', () async {
      var orgName = 'dart-lang';

      var json =
          (await http.get('https://api.github.com/orgs/${orgName}/repos')).body;
      File('repos.json').writeAsStringSync(json);

      var obj = jsonDecode(json);

      final orgRepos = obj.map((e) => GithubRepo.fromJson(e)).toList();
      orgRepos.sort((a, b) => b.watchers - a.watchers);

      var dump = Inspect.dump(orgRepos.take(3));
      expect(dump, isNotEmpty);
      print(dump);

      var table = Inspect.dumpTable(orgRepos.take(10));
      expect(table, isNotEmpty);
      print(table);

      Inspect.vars({'orgRepos': orgRepos});
    });
  });
}
