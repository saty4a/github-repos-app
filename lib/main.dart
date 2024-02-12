import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_flutter_app/providers/repo_provider.dart';
import 'package:simple_flutter_app/providers/user_provider.dart';
import 'package:simple_flutter_app/routes.dart';
import 'package:simple_flutter_app/services/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<RepoProvider>(
          create: (_) => RepoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Github Repos',
        theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white), // Background color of the AppBar
        ),
        ),
        initialRoute: '/',
        routes: Routes.getRoutes(),
      ),
    );
  }
}
