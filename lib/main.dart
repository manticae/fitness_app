import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './design/app_theme.dart';
import './screens/home_screen.dart';
import './providers/authentication_provider.dart';
import './screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  FitnessApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationProvider>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Fitness App',
        theme: AppTheme().appTheme,
        home: const AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
