import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:simple_flutter_app/models/repo_model.dart';

//calling api to get the repos and then decoding it and making a list accoring to our repo model.
class GithubApiService {
  static Future<List<Repo>> fetchRepos(String userName) async {
    final response = await http.get(
        Uri.parse('https://api.github.com/users/$userName/repos'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Repo> repos = data.map((json) => Repo.fromJson(json)).toList();
      return repos;
    } else {
      throw Exception('Failed to load repos');
    }
  }
}
