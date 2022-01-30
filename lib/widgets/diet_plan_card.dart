import 'package:flutter/material.dart';

import '../models/diet_plan_data.dart';

class DietPlanCard extends StatelessWidget {
  const DietPlanCard({Key? key, required this.dietPlanData}) : super(key: key);
  final DietPlanData dietPlanData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print("TODO: Navigation");
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    dietPlanData.image,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dietPlanData.title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
