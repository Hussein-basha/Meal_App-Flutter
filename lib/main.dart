import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/widgets/meal_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Map<String , bool> _filters =
  {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String , bool> _filterData)
  {
    setState(() {
      _filters = _filterData;
      _availableMeals = DUMMY_MEALS.where((meal)
      {
        if(_filters['gluten']! && !meal.isGlutenFree)
          {
            return false;
          }
        if(_filters['lactose']! && !meal.isLactoseFree)
        {
          return false;
        }
        if(_filters['vegan']! && !meal.isVegan)
        {
          return false;
        }
        if(_filters['vegetarian']! && !meal.isVegetarian)
        {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId)
  {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0)
      {
        setState(() {
          _favoriteMeals.removeAt(existingIndex);
        });
      }
    else
      {
        setState(() {
          _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        });
      }

  }

  bool _isMealFavorite(String id)
  {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1)
              ),
              bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1)
              ),
          subtitle1: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/' : (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName : (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName : (context) => MealDetailScreen(_toggleFavorite ,_isMealFavorite),
        FiltersScreen.routeName : (context) => FiltersScreen(_setFilters , _filters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal App',
        ),
      ),
      body: null,
    );
  }
}
