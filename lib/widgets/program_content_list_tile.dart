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
        // ignore: avoid_print
        print("Todo navigate");
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
