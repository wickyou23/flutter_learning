import 'package:flutter/material.dart';

import 'left_menu_screen.dart';
import 'category_page.dart';
import '../utils/extension.dart';
import 'favorite_screen.dart';

class TabbarScreen extends StatefulWidget {
  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  int _tabbarIndexSelected = 0;

  void _selectedTabbar(int index) {
    setState(() {
      _tabbarIndexSelected = index;
    });
  }

  Widget _selectedBody() {
    switch (_tabbarIndexSelected) {
      case 0:
        return CategoryPage();
      case 1:
        return FavoriteScreen();
      default:
        return Scaffold(
          body: Center(
            child: Text('No Page!'),
          ),
        );
    }
  }

  Widget _titleAppBar() {
    switch (_tabbarIndexSelected) {
      case 0:
        return Text('Category Meals');
      case 1:
        return Text('Favourite');
      default:
        return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleAppBar(),
      ),
      body: _selectedBody(),
      drawer: LeftMenuScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabbarIndexSelected,
        elevation: 25.0,
        selectedLabelStyle: context.theme.textTheme.title.copyWith(
          fontSize: 12,
        ),
        unselectedLabelStyle: context.theme.textTheme.title.copyWith(
          fontSize: 12,
        ),
        onTap: _selectedTabbar,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            title: const Text('Category'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            title: const Text('Favorite'),
          ),
        ],
      ),
    );
  }
}
