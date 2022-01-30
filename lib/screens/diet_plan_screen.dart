import 'package:flutter/material.dart';

import '../models/recipe_data.dart';
import '../utils/diet_plans_provider.dart';
import '../models/diet_plan_data.dart';

class DietPlanScreen extends StatelessWidget {
  DietPlanScreen({Key? key}) : super(key: key);
  final DietPlansProvider _dietPlansProvider = DietPlansProvider();
  static const routeName = '/dietPlan';

  @override
  Widget build(BuildContext context) {
    final dietPlanData =
        ModalRoute.of(context)!.settings.arguments as DietPlanData;
    return Scaffold(
      appBar: AppBar(
        title: Text(dietPlanData.title),
      ),
      body: FutureBuilder(
        future: _dietPlansProvider.getRecipesForDietPlan(
          dietPlanId: dietPlanData.uid,
        ),
        builder:
            (BuildContext context, AsyncSnapshot<List<RecipeData>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Något gick fel, försök igen. Om felet kvarstår kontakta ägaren.",
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            List<RecipeData>? recipes = snapshot.data;
            return recipes != null && recipes.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          child: Text(recipes[index].title),
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Center(
                      child: Text(
                        "Det verkar inte finnas några recept i detta program kom tillbaka senare",
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
