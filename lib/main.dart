import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // map passing data
    Map<String,dynamic> _filters = {
    "gluten":false,
    "lactose":false,
    "vegan":false,
    "vegetarian":false
  };

// It will be send to catagories because it can be updated accoring to filters
    List<Meal> _availableMeals = DUMMY_MEALS;

    void _setFilters(Map <String,dynamic> filterData)
  {
    setState(() {
      _filters = filterData;
      _availableMeals=DUMMY_MEALS.where((meal) {
      if(_filters['gluten']==true && !meal.isGlutenFree)
      {
        return false;
      }
      if(_filters['lactose']==true && !meal.isLactoseFree){
        return false;
      }
      if(_filters['vegan']==true && !meal.isVegan){
        return false;
      }
      if(_filters['vegetarian']==true && !meal.isVegetarian){
        return false;
      }
      return true;

      }).toList();
    });

  }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        // '/category-meals' : (ctx) => CategoryMealsScreen(),
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        // print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
