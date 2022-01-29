import 'package:flutter/material.dart';

import '../widgets/program_content_list_tile.dart';
import '../utils/storage_provider.dart';
import '../models/program_data.dart';
import '../models/program_content.dart';

class ProgramScreen extends StatelessWidget {
  ProgramScreen({Key? key}) : super(key: key);
  final StorageProvider _storageProvider = StorageProvider();
  static const routeName = "/program";

  @override
  Widget build(BuildContext context) {
    final programData =
        ModalRoute.of(context)!.settings.arguments as ProgramData;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          programData.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                programData.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            FutureBuilder(
              future: _storageProvider.getProgramContent(
                  programId: programData.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProgramContent>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Något gick fel, försök igen. Om felet kvarstår kontakta ägaren.",
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  List<ProgramContent>? programContent = snapshot.data;
                  return programContent != null && programContent.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: programContent.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 300,
                                child: ProgramContentListTile(
                                  programContent: programContent[index],
                                ),
                              ),
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Center(
                            child: Text(
                              "Det verkar inte finnas något att göra i detta program kom tillbaka senare",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
