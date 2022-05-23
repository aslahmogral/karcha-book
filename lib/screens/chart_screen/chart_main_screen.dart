import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/widgets/custom_tabbar.dart';

import 'expense_chart_screen.dart';
import 'income_chart_screen.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabBar(
        expenseScreen: ExpenseChartScreen(),
        incomeScreen: IncomeChartScreen(),
        TabName: 'Chart');
  }
}
