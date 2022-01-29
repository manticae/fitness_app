import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/role.dart';
import '../screens/settings_screen.dart';
import '../screens/faq_screen.dart';
import '../screens/admin_screen.dart';
import '../utils/storage_provider.dart';
import '../models/user_data.dart';
import '../utils/authentication_provider.dart';
import '../design/theme_colors.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({Key? key}) : super(key: key);

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  final StorageProvider _storageProvider = StorageProvider();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return Drawer(
      child: FutureBuilder<UserData?>(
        future: _storageProvider.getUserdata(uid: firebaseUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<UserData?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Något gick fel, försök igen. Om felet kvarstår kontakta ägaren.",
              ),
            );
          }

          if (snapshot.hasData && snapshot.data == null) {
            return const Text(
              "Det saknas information, försök igen. Om felet kvarstår kontakta ägaren.",
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            UserData? userData = snapshot.data;
            return userData != null
                ? Column(
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: ThemeColors.primary,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.account_circle_rounded,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '${userData.firstName} ${userData.lastName}',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ],
                            ),
                            Text(
                              userData.email,
                            ),
                          ],
                        ),
                      ),
                      userData.role == Role.admin
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AdminScreen.routeName,
                                );
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.create,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'Till adminsida',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            FAQScreen.routeName,
                          );
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.question_answer,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'FAQ',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SettingsScreen.routeName,
                          );
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'Inställningar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthenticationProvider>().signOut();
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.logout,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text('Logga ut'),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                    'Manticae',
                                  ),
                                  content: Text(
                                    'version: 1.0.0+1',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.info_outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : TextButton(
                    onPressed: () {
                      context.read<AuthenticationProvider>().signOut();
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('Logga ut'),
                      ],
                    ),
                  );
          }

          return const Center(
            child: Text(
              "Hämtar data...",
            ),
          );
        },
      ),
    );
  }
}
