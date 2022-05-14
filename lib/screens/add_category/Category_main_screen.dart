import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/add_category/category_Income_screen.dart';

import 'category_expense_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category'),
          centerTitle: true,
          

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
        body: TabBarView(
            children: [ExpenseCategoryScreen(), IncomeCategoryScreen()]),
      ),
    );
  }
}
