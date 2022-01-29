import 'package:flutter/material.dart';

import '../screens/program_screen.dart';
import '../models/program_data.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard({
    Key? key,
    required this.programData,
    this.isInverted = false,
  }) : super(key: key);
  final ProgramData programData;
  final bool isInverted;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProgramScreen.routeName,
          arguments: {'uid': programData.uid},
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 200,
          ),
          child: IntrinsicHeight(
            child: Row(
              textDirection: isInverted ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          programData.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          programData.description,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: isInverted
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              end: isInverted
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              colors: const [Colors.black, Colors.transparent],
                            ).createShader(
                              Rect.fromLTRB(
                                0,
                                0,
                                rect.width,
                                rect.height,
                              ),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.network(
                            programData.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
