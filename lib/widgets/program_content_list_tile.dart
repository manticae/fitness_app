import 'package:fitness_app/screens/traning_session_screen.dart';
import 'package:flutter/material.dart';

import '../models/program_content.dart';

class ProgramContentListTile extends StatelessWidget {
  final ProgramContent programContent;
  const ProgramContentListTile({Key? key, required this.programContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, TraningSessionScreen.routeName,
            arguments: programContent);
      },
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
      ),
      title: Text(
        programContent.title,
      ),
    );
  }
}
