import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_flutter_project/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME ='transaction_database';

abstract class TransactionDbFunctions{
  Future<void> insertTransaction(TransactionModel value);
  Future<List<TransactionModel>>getTransactions();
  Future<void> deleteTransaction(String transactionID);
}
class TransactionDB implements TransactionDbFunctions{

  TransactionDB.internal();
  static TransactionDB instance = TransactionDB.internal();
  factory TransactionDB(){
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);

  @override
  Future<void> insertTransaction(TransactionModel value)async {
    final _transactionDB= await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _transactionDB.put(value.id, value);
    refreshTransactionUI();
  }

  @override
  Future<List<TransactionModel>> getTransactions()async {
    final _transactionDB= await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDB.values.toList();
  }

  Future<void>refreshTransactionUI()async{
    final _allTransactionList = await getTransactions();
    _allTransactionList.sort((firstIndex,secondIndex)
    =>secondIndex.date.compareTo(firstIndex.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_allTransactionList);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTransaction(transactionID)async {
    final _transactionDB= await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.delete(transactionID);
    refreshTransactionUI();
  }
}