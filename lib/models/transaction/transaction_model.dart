import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_flutter_project/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String purpose;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final CategoryType type;
  @HiveField(5)
  final CategoryModel category;

  TransactionModel({
    required this.id,
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });
}



