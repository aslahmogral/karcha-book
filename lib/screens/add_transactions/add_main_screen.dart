import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/widgets/custom_tabbar.dart';

import 'add_expense_screen.dart';
import 'add_income_screen.dart';

class AddIncomeAndExpenseScreen extends StatefulWidget {
  const AddIncomeAndExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddIncomeAndExpenseScreen> createState() =>
      _AddIncomeAndExpenseScreenState();
}

class _AddIncomeAndExpenseScreenState extends State<AddIncomeAndExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomTabBar(
        expenseScreen: AddExpenseScreen(),
        incomeScreen: AddIncomeScreen(),
        TabName: 'Add Expense and Income');
  }
}
