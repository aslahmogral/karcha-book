import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/add_category/category_Income_screen.dart';
import 'package:money_manager_app/screens/widgets/custom_tabbar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'category_expense_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomTabBar(
        expenseScreen: ExpenseCategoryScreen(),
        incomeScreen: IncomeCategoryScreen(),
        TabName: 'Add Category');
  }
}
