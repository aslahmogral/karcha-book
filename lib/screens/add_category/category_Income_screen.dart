import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/functions/functions.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';
import 'package:money_manager_app/screens/widgets/custom_dialogbox.dart';
import 'package:money_manager_app/screens/widgets/custom_valuelistenablebuilder.dart';

class IncomeCategoryScreen extends StatefulWidget {
  const IncomeCategoryScreen({Key? key}) : super(key: key);

  @override
  State<IncomeCategoryScreen> createState() => _IncomeCategoryScreenState();
}

class _IncomeCategoryScreenState extends State<IncomeCategoryScreen> {
  var incomeBox = Hive.box<categoryModel>('incomeCategoryBox');
  categoryModel? incomeDetails;

  final incomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: incomeBox.isNotEmpty
          ? CustomValuelistenableBuilder(
              boxName: 'incomeCategoryBox',
              categoryType: true,
            )
          : Container(
              child: Center(
                child: Text('No Income Category Added'),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: KarchaFabcolor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                    controller: incomeController,
                    box: incomeBox,
                    transactionType: true);
              });
        },
        label: Text(
          '+ Add Income Category',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
