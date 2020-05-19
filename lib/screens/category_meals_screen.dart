import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/enums/screenName.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const ScreenName screenName = ScreenName.Meals;
  //final String mealId;
  final Category category;
  final List<Meal> availableMeals;
  
  CategoryMealsScreen(this.category, this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> displayedMeals;

  @override
  void initState() {
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(widget.category.id);
    }).toList();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   if(_loadedInitData)
  //     return;
    
  //   final routeArgs =
  //       ModalRoute.of(context).settings.arguments as Map<String, String>;
  //   categoryTitle = routeArgs['title'];
  //   final categoryId = routeArgs['id'];
  //   displayedMeals = widget.availableMeals.where((meal) {
  //     return meal.categories.contains(categoryId);
  //   }).toList();
  //   _loadedInitData = true;
  //   super.didChangeDependencies();
  // }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
