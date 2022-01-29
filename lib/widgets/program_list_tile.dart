import 'package:flutter/material.dart';

import '../models/program_data.dart';
import '../screens/program_screen.dart';

class ProgramListTile extends StatelessWidget {
  const ProgramListTile({
    Key? key,
    required this.programData,
  }) : super(key: key);
  final ProgramData programData;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProgramScreen.routeName,
          arguments: programData,
        );
      },
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
      ),
      title: Text(
        programData.title,
      ),
      subtitle: Text(programData.description),
    );
  }
}
