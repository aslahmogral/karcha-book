import 'package:flutter/cupertino.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';






//for adding income and exp category
ValueNotifier<List<categoryModel>> IncomeCategorylist = ValueNotifier([]); 
ValueNotifier<List<categoryModel>> ExpenseCategorylist = ValueNotifier([]);

void addIncomeCategory(categoryModel value) {
  IncomeCategorylist.value.add(value);
  IncomeCategorylist.notifyListeners();
}

void addExpenseCategory(categoryModel value) {
  ExpenseCategorylist.value.add(value);
  ExpenseCategorylist.notifyListeners();
}

// for adding income and exp transaction
ValueNotifier<List<addExpAndIncModel>> ExpenseAndIncomeList = ValueNotifier([]);


void addExpenseAndIncomeList(addExpAndIncModel value) {
  ExpenseAndIncomeList.value.add(value);
  ExpenseAndIncomeList.notifyListeners();
}







