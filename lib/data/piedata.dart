import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/moneymanagermodel.dart';

var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');
var expenseBox = Hive.box<categoryModel>('expenseCategoryBox');

class PieData {
  static List<Data> data = lists;

  // Data(name: 'blue', percent: 40, color: Colors.blue),
  // Data(name: 'red', percent: 20, color: Colors.red),
  // Data(name: 'green', percent: 20, color: Colors.green),
  // Data(name: 'yello', percent: 20, color: Colors.yellow),

}

class Data {
  final String categoryName;
  final double percent;
  final Color color;
  Data(
      {required this.categoryName, required this.percent, required this.color});
}

List<Color> colors = [Colors.yellow, Colors.blue, Colors.red, Colors.green];

List<String> CategoryName = [];
List<categoryModel> expense = expenseBox.values.toList();
List catName = ['hi', 'bi', 'cu', 'wellcome'];

List<double> percent = [20, 30, 40, 50];
List<Data> lists = [];

getListMethod() {
  for (int i = 0; i < 3; i++) {
    // CategoryName[i]=expense[i].categoryName;
    lists[i] =
        Data(categoryName: catName[i], percent: percent[i], color: colors[i]);
  }
  return CategoryName;
}
