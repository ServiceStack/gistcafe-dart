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
