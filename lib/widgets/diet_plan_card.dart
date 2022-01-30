import 'package:flutter/material.dart';

import '../screens/diet_plan_screen.dart';
import '../models/diet_plan_data.dart';

class DietPlanCard extends StatelessWidget {
  const DietPlanCard({Key? key, required this.dietPlanData}) : super(key: key);
  final DietPlanData dietPlanData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DietPlanScreen.routeName,
            arguments: dietPlanData);
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
