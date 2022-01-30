import 'package:flutter/material.dart';

import '../widgets/diet_plan_card.dart';
import '../utils/diet_plans_provider.dart';
import '../models/diet_plan_data.dart';

class DietPlansFeedScreen extends StatelessWidget {
  DietPlansFeedScreen({Key? key}) : super(key: key);
  final DietPlansProvider _dietPlansProvider = DietPlansProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dietPlansProvider.getAllDietPlans(),
      builder:
          (BuildContext context, AsyncSnapshot<List<DietPlanData>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Något gick fel, försök igen. Om felet kvarstår kontakta ägaren.",
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List<DietPlanData>? dietPlans = snapshot.data;
          return dietPlans != null
              ? ListView.builder(
                  itemCount: dietPlans.length,
                  itemBuilder: (context, index) {
                    return DietPlanCard(
                      dietPlanData: dietPlans[index],
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
