import 'package:fitness_app/design/theme_colors.dart';
import 'package:fitness_app/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.secondary,
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Logga in",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      label: Text("Email"),
                    ),
                    controller: emailController,
                  ),
                  TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      label: Text("Lösenord"),
                    ),
                    controller: passwordController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          context.read<AuthenticationProvider>().signIn(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                        },
                        child: const Text("LOGGA IN"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
