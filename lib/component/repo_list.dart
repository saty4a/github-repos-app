import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_flutter_app/providers/repo_provider.dart';

class RepoList extends StatelessWidget {
  final int index;
  final String? name, description;
  final GlobalKey<AnimatedListState> listKey;
  const RepoList({super.key, required this.index, required this.name, required this.description, required this.listKey});

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<RepoProvider>(context);
    final Color color1 = Color(0xFF000000 + Random().nextInt(0xFFFFFF));
    final Color color2 = Color(0xFF000000 + Random().nextInt(0xFFFFFF));

    return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [color1, color2], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: ListTile(
              title: Text(
                name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                      description ?? "",
                      style: const TextStyle(fontSize: 14),
                    ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  repoProvider.deleteRepo(index, listKey);
                },
              ),
            ),
            )
          );
  }
}