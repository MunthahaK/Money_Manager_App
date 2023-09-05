import 'package:flutter/material.dart';
import 'package:money_manager_flutter_project/screens/category/category_screen.dart';
import 'package:money_manager_flutter_project/screens/category/popup_category.dart';
import 'package:money_manager_flutter_project/screens/transaction/addtransaction_screen.dart';
import 'package:money_manager_flutter_project/screens/transaction/transaction_screen.dart';

import 'widgets/bottom_navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final _pages = [
    TransactionScreen(),
    CategoryScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (ctx, updatedIndex, _){
          return _pages[updatedIndex];
        },
      ),
      bottomNavigationBar: ScreenBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(selectedIndex.value == 0){
            print('Add Transaction');
            Navigator.of(context).pushNamed(AddTransactionScreen.routeName);
          }else {
            showPopUpCategory(context);
            /* print('Add Category');
              final _sample = CategoryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: 'Travel',
                  type: CategoryType.expense
              );
              CategoryDB().insertCategory(_sample);*/
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
