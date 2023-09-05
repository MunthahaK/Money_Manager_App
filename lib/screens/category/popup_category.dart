import 'package:flutter/material.dart';
import 'package:money_manager_flutter_project/db/category/category_db.dart';
import 'package:money_manager_flutter_project/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.expense);

Future<void> showPopUpCategory(BuildContext context)async{
  final _nameController = TextEditingController();
  return showDialog(
      context: context,
      builder: (ctx){
        return SimpleDialog(
          title: Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Category Name'
                ),
              ),
            ),
            Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: (){
                    final _name = _nameController.text.toUpperCase();
                    if(_name.isEmpty){
                      return;
                    }
                    final _type = selectedCategoryNotifier.value;
                    final _category = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type
                    );
                    CategoryDB().insertCategory(_category);
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Add')
              ),
            )
          ],
        );
      }
  );
}
class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key,required this.title,required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx,CategoryType newCategory,Widget? _){
            return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value){
                  if(value == null){
                    return;
                  }
                  selectedCategoryNotifier.value=value;
                  selectedCategoryNotifier.notifyListeners();
                }
            );
          },
        ),
        Text(title)
      ],
    );
  }
}
