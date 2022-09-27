import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'You Have No Favorites Yet - Start Adding Some!',
        ),
      );
    }
    else
      {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id :  favoriteMeals[index].id,
              title :  favoriteMeals[index].title,
              imageUrl :  favoriteMeals[index].imageUrl,
              duration :  favoriteMeals[index].duration,
              complexity :  favoriteMeals[index].complexity,
              affordability :  favoriteMeals[index].affordability,
              // removeItem: _removeMeal,
            );
          },
          itemCount: favoriteMeals.length,
        );
      }
  }
}
