import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/functions/functions.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';

class ExpenseCategoryScreen extends StatefulWidget {
  const ExpenseCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseCategoryScreen> createState() => _ExpenseCategoryScreenState();
}

class _ExpenseCategoryScreenState extends State<ExpenseCategoryScreen> {
  var expenseBox = Hive.box<categoryModel>('expenseCategoryBox');
  // final bool checkTransactionType = false;
  final expenseController = TextEditingController();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box<categoryModel>('expenseCategoryBox').listenable(),
        builder: (BuildContext ctx, Box<categoryModel> newBox, Widget? child) {
          List<categoryModel> expenseData = newBox.values.toList();
          List keys = newBox.keys.toList();
          return ListView.builder(
              itemCount: expenseData.length,
              itemBuilder: (ctx, index) {
                final data = expenseData[index];

                return ListTile(
                  title: data.categoryType == false
                      ? Text(data.categoryName)
                      : Container(),
                  // Text(data.categoryName)
                  trailing: Wrap(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // deleteExpense();
                          },
                          child: GestureDetector(
                              onTap: () {
                                newBox.delete(keys[index]);
                              },
                              child: Icon(Icons.delete)))
                    ],
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  // title: Text('Add expense category'),
                  content: TextField(
                    controller: expenseController,
                    decoration: InputDecoration(hintText: 'expense category'),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (expenseController.text.isEmpty) {
                            expenseController.clear();
                            Navigator.pop(context);
                            return;
                          } else {
                            final expenseDetails = categoryModel(
                                categoryName: expenseController.text,
                                categoryType: false);

                            expenseBox.add(expenseDetails);
                            expenseController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Save'))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
