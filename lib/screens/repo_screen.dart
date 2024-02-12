import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_flutter_app/component/repo_list.dart';
import 'package:simple_flutter_app/providers/repo_provider.dart';
import 'package:simple_flutter_app/providers/user_provider.dart';
import 'package:simple_flutter_app/services/auth.dart';

class ReposScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  ReposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<RepoProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    listKey.currentState?.insertItem(repoProvider.repos.length -1);

    //checking if user is present or not
    if (user.userId == null) {
      // Navigate to the login screen
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(),
              );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('GitHub Repos')),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await authService.signOut();
                user.clearUser();
                repoProvider.clearRepos();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
        body: Center(
          child: SizedBox(
            width: screenSize.width * 0.9,
            height: screenSize.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenSize.height * 0.05),
                Text(
                  'Logged in as: ${user.email}', // Display user email
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenSize.height * 0.03),
                TextField( // get github user name
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter GitHub Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final username = _usernameController.text;
                    if (username.isNotEmpty) {
                      repoProvider.fetchRepos(username);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('field Cannot be empty')),
                      );
                    }
                  },
                  child: const Text('Fetch Repositories'),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer<RepoProvider>(
                    builder: (context, repoProvider, _) {
                      if (repoProvider.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (repoProvider.repos.isEmpty) {
                        return const Center(child: Text('No repos found'));
                      } else {
                        // Display list of repos using RepoList widget
                        return AnimatedList(
                          key: listKey,
                          initialItemCount: repoProvider.repos.length,
                          itemBuilder: (context, index, animation) {
                            final repo = repoProvider.repos[index];
                            return SizeTransition(
                              sizeFactor: animation,
                              child: RepoList(
                                index: index,
                                name: repo.name,
                                description: repo.description,
                                listKey: listKey,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}