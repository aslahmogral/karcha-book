import 'package:flutter/material.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Expense and Income'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(tabs: [
            Tab(
              text: 'Expense',
            ),
            Tab(
              text: 'Income',
            )
          ]),
        ),
        body: TabBarView(children: [AddExpenseScreen(),AddIncomeScreen() ]),
      ),
    );
  }
}
