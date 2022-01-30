import 'package:flutter/material.dart';

import '../utils/programs_provider.dart';
import '../models/exercise.dart';
import '../models/program_content.dart';

class TraningSessionScreen extends StatelessWidget {
  TraningSessionScreen({Key? key}) : super(key: key);
  static const routeName = "/traningSession";
  final ProgramsProvider _programsProvider = ProgramsProvider();

  @override
  Widget build(BuildContext context) {
    final programContent =
        ModalRoute.of(context)!.settings.arguments as ProgramContent;

    return Scaffold(
      appBar: AppBar(
        title: Text(programContent.title),
      ),
      body: FutureBuilder(
        future: _programsProvider.getExercisesForProgramContent(
            programContentId: programContent.uid),
        builder:
            (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Något gick fel, försök igen. Om felet kvarstår kontakta ägaren.",
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            List<Exercise>? exercises = snapshot.data;
            return exercises != null && exercises.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercises[index].title,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        )),
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
    );
  }
}
