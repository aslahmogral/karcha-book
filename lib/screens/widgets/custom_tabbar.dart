import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final expenseScreen;
  final incomeScreen;
  final String TabName;
  const CustomTabBar(
      {Key? key, required this.expenseScreen, required this.incomeScreen, required this.TabName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TabName),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              text: 'Expense',
            ),
            Tab(
              text: 'Income',
            )
          ]),
        ),
        body: TabBarView(children: [expenseScreen, incomeScreen]),
      ),
    );
  }
}
