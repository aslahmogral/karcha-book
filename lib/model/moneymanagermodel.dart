import 'package:hive/hive.dart';
part 'moneymanagermodel.g.dart';



@HiveType(typeId: 1)
class categoryModel {
  @HiveField(0)
  final bool categoryType;
  @HiveField(1)
  final String categoryName;
  categoryModel({required this.categoryName, required this.categoryType});
}

@HiveType(typeId: 2)
class addExpAndIncModel {
  @HiveField(0)
  final bool transactionType;

  @HiveField(1)
  final DateTime dateOftransaction;

  @HiveField(2)
  final categoryName;
  @HiveField(3)
  final int amount;

  var categoryType;
  addExpAndIncModel(
      {required this.categoryName,
      required this.amount,
      required this.dateOftransaction,
      required this.transactionType});
}
