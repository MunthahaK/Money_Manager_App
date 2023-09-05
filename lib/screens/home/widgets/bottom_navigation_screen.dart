import 'package:flutter/material.dart';
import 'package:money_manager_flutter_project/screens/home/screen_home.dart';

class ScreenBottomNavigation extends StatelessWidget {
  const ScreenBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndex,
      builder: (ctx, updatedIndex, Widget?_){
        return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (updatedIndex){
              HomeScreen.selectedIndex.value = updatedIndex;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Transactions'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categories'
              )
            ]
        );
      },

    );
  }
}
