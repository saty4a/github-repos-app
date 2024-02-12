import 'package:flutter/material.dart';
import 'package:simple_flutter_app/models/repo_model.dart';
import 'package:simple_flutter_app/services/api.dart';

class RepoProvider extends ChangeNotifier {
  final List<Repo> _repos = [];
  String _error = '';
  bool _loading = false;

  List<Repo> get repos => _repos;
  String get error => _error;
  bool get loading => _loading;

  void setError(String error) {
    _error = error;
    _loading = false;
    notifyListeners();
  }

  //setting loading variable
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  //fetching repos from github and assigning it to our list
  Future<void> fetchRepos(String username) async {
    setLoading(true);
    try {
      final repos = await GithubApiService.fetchRepos(username);
      clearRepos();
      _repos.addAll(repos);
      _error = '';
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
    setLoading(false);
  }

  //clearing all the list
  void clearRepos(){
    _repos.clear();
  }

  //deleting a repo from the list
  void deleteRepo(int index, GlobalKey<AnimatedListState> listKey) {
    listKey.currentState!.removeItem(
      index,
      (context, animation) => const SizedBox.shrink(),
      duration: const Duration(seconds: 2),
    );
    _repos.removeAt(index);
    notifyListeners();
  }
}