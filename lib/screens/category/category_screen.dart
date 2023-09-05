import 'package:flutter/material.dart';
import 'package:money_manager_flutter_project/db/category/category_db.dart';
import 'package:money_manager_flutter_project/screens/category/expense_category.dart';
import 'package:money_manager_flutter_project/screens/category/income_category.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>with SingleTickerProviderStateMixin{

  late TabController _tabController;
  void initState(){
    _tabController=TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TabBar(
              controller: _tabController ,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'INCOME',),
                Tab(text: 'EXPENSE',)
              ]
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  IncomeCategoryScreen(),
                  ExpenseCategoryScreen()
                ]
            ),
          )
        ]
    );
  }
}
