import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_flutter_project/db/category/category_db.dart';
import 'package:money_manager_flutter_project/db/transaction/transaction_db.dart';
import 'package:money_manager_flutter_project/models/category/category_model.dart';


class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB().refreshTransactionUI();
    CategoryDB().refreshUI();

    return ValueListenableBuilder(
      valueListenable: TransactionDB().transactionListNotifier,
      builder: (ctx, newList, Widget_){
        if(newList.isEmpty){
          return const  Center(child: Text('Your transactions will appear here',
              style: TextStyle(color: Colors.teal,fontStyle: FontStyle.italic)));
        }
        return ListView.separated(
            padding: EdgeInsets.all(10),
            itemBuilder: (ctx,index){
              return Slidable(
                key:Key(newList[index].id),
                startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      Icon(Icons.delete,color: Colors.teal),
                      SlidableAction(
                        onPressed: (ctx){
                          TransactionDB().deleteTransaction(newList[index].id);
                        },
                        label: 'Delete',
                      )
                    ]
                ),
                child: Card(color: Colors.teal[50],
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: newList[index].type==CategoryType.income
                            ?Colors.teal
                            :Colors.red,
                        radius: 50,
                        child: Text(dateDisplay(newList[index].date),
                            style:TextStyle(color: Colors.white) ,
                            textAlign: TextAlign.center)
                    ),
                    title: Text('Rs.${newList[index].amount}'),
                    subtitle: Text('${newList[index].purpose}\n-${newList[index].category.name}'),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx,index){
              return SizedBox(height: 10);
            },
            itemCount: newList.length
        );
      },
    );
  }
  String dateDisplay(DateTime date){
    final _date = DateFormat.MMMd().format(date);
    final _splitDate = _date.split(' ');
    return '${_splitDate.last}\n${_splitDate.first}';
  }
}
