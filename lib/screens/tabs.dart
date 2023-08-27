import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoritesMeal = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: Text(message),
      ),
    );
  }

  void toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoritesMeal.contains(meal);

    if (isExisting) {
      setState(() {
        _favoritesMeal.remove(meal);
      });
      _showInfoMessage('Meal is deleted from favorites');
    } else {
      setState(() {
        _favoritesMeal.add(meal);
      });
      _showInfoMessage('Meal is added to favorites');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePageTitle = 'Favorites';
      activePage = MealsScreen(
        meals: _favoritesMeal,
        onToggleFavorite: toggleMealFavoriteStatus,
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: const MainDrawer(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
        onTap: _selectPage,
      ),
    );
  }
}
