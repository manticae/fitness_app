import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/program_list_tile.dart';
import '../widgets/program_card.dart';
import '../models/program_data.dart';
import '../utils/storage_provider.dart';

class ProgramFeedScreen extends StatelessWidget {
  ProgramFeedScreen({Key? key}) : super(key: key);

  final StorageProvider _storageProvider = StorageProvider();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 24.0,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Mina program',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          SizedBox(
            height: 150.0,
            child: FutureBuilder(
              future: _storageProvider.getUserPrograms(
                userId: firebaseUser!.uid,
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProgramData>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Något gick fel, försök igen. Om felet kvarstår kontakta ägaren.",
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  List<ProgramData>? programs = snapshot.data;
                  return programs != null
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: programs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 300,
                                child: ProgramListTile(
                                  programData: programs[index],
                                ),
                              ),
                            );
                          },
                        )
                      : const Text("Inga program");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Alla program',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: FutureBuilder(
              future: _storageProvider.getPublicPrograms(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProgramData>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Något gick fel, försök igen. Om felet kvarstår kontakta ägaren.",
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  List<ProgramData>? programs = snapshot.data;
                  return programs != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: programs.length,
                          itemBuilder: (context, index) {
                            return ProgramCard(
                              programData: programs[index],
                              isInverted: index % 2 == 0,
                            );
                          },
                        )
                      : const Text("Inga program");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
