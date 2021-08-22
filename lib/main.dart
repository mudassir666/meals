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
  // map passing data
  Map<String, dynamic> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false
  };

// It will be send to catagories because it can be updated accoring to filters
  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, dynamic> filterData) {
    setState(() {
      print("8");
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        // print(_filters['gluten']);
        print(_filters['vegetarian']);
        return true;
      }).toList();
    });
  }

  // void _toggleFavorite(String mealId) {
  //   // to remove already existing favorite
  //   final existingIndex =
  //       _favoriteMeals.indexWhere((meal) => meal.id == mealId);
  //   if (existingIndex >= 0) {
  //     setState(() {
  //       _favoriteMeals.removeAt(existingIndex);
  //     });
  //   } else {
  //     // it will be added to favorite list
  //     setState(() {
  //       _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
  //     });
  //   }
  // }

    void _toggleFavorite(String mealid)
  {
    final extistingindex = _favoriteMeals.indexWhere((element) => element.id==mealid);
    if(extistingindex >= 0)
    {
      setState(() {
       _favoriteMeals.removeAt(extistingindex);
      });

    }
    else{
      setState(() {
       _favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id==mealid));
      });
      
    }
  }

  bool _isMealFavorite(String id) {
    // checking if i have the id of the favorite meal
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
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
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
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
