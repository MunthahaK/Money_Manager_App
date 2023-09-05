
import 'package:flutter/material.dart';
import 'package:money_manager_flutter_project/db/category/category_db.dart';

class ExpenseCategoryScreen extends StatelessWidget {
  const ExpenseCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenseCategoryList,
      builder: (BuildContext ctx, newList, Widget? _){
        return ListView.separated(
            padding: EdgeInsets.all(8),
            itemBuilder: (ctx,index){
              return Card(color: Colors.teal[50],
                child: ListTile(
                  title: Text(newList[index].name),
                  trailing: IconButton(
                      onPressed: (){
                        CategoryDB().deleteCategory(newList[index].id);
                      },
                      icon: Icon(Icons.delete,color: Colors.teal)
                  ),
                ),
              );
            },
            separatorBuilder: (ctx,index){return SizedBox(height: 10);},
            itemCount: newList.length
        );
      },

    );
  }
}
