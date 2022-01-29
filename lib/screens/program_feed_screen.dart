import 'package:flutter/material.dart';

import '../widgets/program_card.dart';
import '../models/program_data.dart';
import '../utils/storage_provider.dart';

class ProgramFeedScreen extends StatelessWidget {
  ProgramFeedScreen({Key? key}) : super(key: key);

  final StorageProvider _storageProvider = StorageProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _storageProvider.getPrograms(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProgramData>> snapshot) {
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
                  itemCount: programs.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        color: Colors.white,
                        height: 200,
                        child: const Center(
                          child: Text('data'),
                        ),
                      );
                    }
                    return ProgramCard(
                      programData: programs[index - 1],
                      isInverted: index % 2 == 0,
                    );
                  },
                )
              : const Text("Inga program");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
