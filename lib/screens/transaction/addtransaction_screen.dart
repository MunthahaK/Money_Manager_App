import 'package:flutter/material.dart';
import 'package:money_manager_flutter_project/db/category/category_db.dart';
import 'package:money_manager_flutter_project/db/transaction/transaction_db.dart';
import 'package:money_manager_flutter_project/models/category/category_model.dart';
import 'package:money_manager_flutter_project/models/transaction/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  static const routeName = 'add_transaction';
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}
class _AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  final _purposeTextController = TextEditingController();
  final _amountTextController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  TextFormField(
                      controller: _purposeTextController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Purpose'
                      )
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      controller: _amountTextController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Amount'
                      )
                  ), const SizedBox(height: 10),
                  TextButton.icon(
                      onPressed: ()async{
                        final _selectedDateTemp =await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(Duration(days: 30*2)),
                            lastDate: DateTime.now()
                        );
                        if(_selectedDateTemp == null){
                          return;
                        }else{
                          setState(() {
                            _selectedDate = _selectedDateTemp;
                          });
                        }
                      },
                      icon: Icon(Icons.calendar_today),
                      label: Text(_selectedDate==null?'Select Date':_selectedDate.toString())
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: CategoryType.income,
                              groupValue:_selectedCategoryType,
                              onChanged: (value){
                                setState(() {
                                  _selectedCategoryType = CategoryType.income;
                                  _categoryID = null;
                                });
                              }
                          ),
                          Text('Income')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: CategoryType.expense,
                              groupValue: _selectedCategoryType,
                              onChanged: (value){
                                setState(() {
                                  _selectedCategoryType = CategoryType.expense;
                                  _categoryID = null;
                                });
                              }
                          ),
                          Text('Expense')
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: DropdownButton(
                        hint: Text('Select Category'),
                        value: _categoryID,
                        items: (_selectedCategoryType == CategoryType.income
                            ?CategoryDB().incomeCategoryList
                            :CategoryDB().expenseCategoryList
                        ).value.map((e){
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name),
                            onTap: (){
                              _selectedCategoryModel = e;
                            },
                          );
                        }).toList(),
                        onChanged: (selectedValue){
                          setState(() {
                            _categoryID = selectedValue;
                          });
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: ElevatedButton(
                        onPressed: (){
                          submitTransaction();
                        },
                        child: Text("Submit")
                    ),
                  )
                ],),
            )
        )
    );
  }
  Future<void> submitTransaction()async{
    final _purpose = _purposeTextController.text;
    final _amount = _amountTextController.text;
    if(_purpose.isEmpty){return;}
    if(_amount.isEmpty){return;}
    if(_selectedDate==null){return;}
    if(_selectedCategoryModel==null){return;}
    final _parsedAmount = double.tryParse(_amount);
    if(_parsedAmount==null){return;}

    final _transaction=TransactionModel(
        id:  DateTime.now().millisecondsSinceEpoch.toString(),
        purpose: _purpose,
        amount: _parsedAmount,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!
    );
    TransactionDB().insertTransaction(_transaction);
    Navigator.of(context).pop();
  }
}
