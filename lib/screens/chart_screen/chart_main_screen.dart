import 'package:flutter/material.dart';

import 'expense_chart_screen.dart';
import 'income_chart_screen.dart';



class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chart'),
          centerTitle: true,
          // title: Text('Add Category'),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 20),
          //     child: Icon(Icons.add),
          //   )
          // ],

          // centerTitle: true,
          // leading: Icon(Icons.arrow_back),

          bottom: TabBar(tabs: [
            Tab(
              text: 'Expense',
            ),
            Tab(
              text: 'Income',
            )
          ]),
        ),
        body: TabBarView(children: [ExpenseChartScreen(), IncomeChartScreen()]),
        
      ),
    );
  }
}
