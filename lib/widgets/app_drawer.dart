import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/models/user_data.dart';
import 'package:fitness_app/utils/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_storage/firebase_storage.dart';

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
            UserData? data = snapshot.data;
            return data != null
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
                                  '${data.firstName} ${data.lastName}',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            Text(
                              data.email,
                            ),
                          ],
                        ),
                      ),
                      data.role == 'admin'
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/admin');
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
                          Navigator.pushNamed(context, '/FAQ');
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
                          Navigator.pushNamed(context, '/settings');
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
