import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';
import 'package:money_manager_app/screens/widgets/custom_dialogbox.dart';
import 'package:money_manager_app/screens/widgets/custom_valuelistenablebuilder.dart';

class ExpenseCategoryScreen extends StatefulWidget {
  const ExpenseCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseCategoryScreen> createState() => _ExpenseCategoryScreenState();
}

class _ExpenseCategoryScreenState extends State<ExpenseCategoryScreen> {
  var expenseBox = Hive.box<categoryModel>('expenseCategoryBox');
  final expenseController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomValuelistenableBuilder(
        boxName: 'expenseCategoryBox',
        categoryType: false,
      ),
      
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                    controller: expenseController,
                    box: expenseBox,
                    transactionType: false);
              });
        },
      ),
    );
  }
}
