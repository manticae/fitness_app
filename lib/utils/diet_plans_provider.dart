import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/diet_plan_data.dart';
import '../models/recipe_data.dart';

class DietPlansProvider {
  Future<List<DietPlanData>> getAllDietPlans() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('dietPlans').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allDietPlans =
        querySnapshot.docs;

    List<DietPlanData> dietPlans = [];
    for (var dietPlan in allDietPlans) {
      dietPlans.add(
        DietPlanData(
          title: dietPlan.data()['title'],
          uid: dietPlan.id,
          image: dietPlan.data()['image'],
        ),
      );
    }
    return dietPlans;
  }

  Future<List<RecipeData>> getRecipesForDietPlan({
    required String dietPlanId,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('recipes')
        .where('dietPlan', isEqualTo: dietPlanId)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allRecipes =
        querySnapshot.docs;

    List<RecipeData> recipes = [];
    for (var recipe in allRecipes) {
      recipes.add(
        RecipeData(
          title: recipe.data()['title'],
          uid: recipe.id,
          dietPlan: recipe.data()['dietPlan'],
        ),
      );
    }
    return recipes;
  }
}
