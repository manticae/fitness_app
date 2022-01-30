import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../screens/diet_plan_screen.dart';
import './screens/traning_session_screen.dart';
import './screens/program_screen.dart';
import './screens/settings_screen.dart';
import './screens/faq_screen.dart';
import './screens/admin_screen.dart';
import './design/app_theme.dart';
import './screens/home_screen.dart';
import './utils/authentication_provider.dart';
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
        debugShowCheckedModeBanner: false,
        title: 'Fitness App',
        theme: AppTheme().appTheme,
        initialRoute: AuthenticationWrapper.routeName,
        routes: {
          AuthenticationWrapper.routeName: (context) =>
              const AuthenticationWrapper(),
          AdminScreen.routeName: (context) => const AdminScreen(),
          FAQScreen.routeName: (context) => const FAQScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
          ProgramScreen.routeName: (context) => ProgramScreen(),
          TraningSessionScreen.routeName: (context) => TraningSessionScreen(),
          DietPlanScreen.routeName: (context) => DietPlanScreen(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  static const routeName = '/';

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
