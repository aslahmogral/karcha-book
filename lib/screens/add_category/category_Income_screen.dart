import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';

import '../../functions/functions.dart';

class IncomeCategoryScreen extends StatefulWidget {
  const IncomeCategoryScreen({Key? key}) : super(key: key);

  @override
  State<IncomeCategoryScreen> createState() => _IncomeCategoryScreenState();
}

class _IncomeCategoryScreenState extends State<IncomeCategoryScreen> {
  var incomeBox = Hive.box<categoryModel>('incomecategoryBox');

  // final bool checkTransactionType = true;
  // List incomeList = [];
  // int count = 0;

  // List expenselists = [];
  final incomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box<categoryModel>('incomecategoryBox').listenable(),
        builder: (BuildContext ctx, Box<categoryModel> newBox, Widget? child) {
          List<categoryModel> incomeData = newBox.values.toList();
          List keys = newBox.keys.toList();
          return ListView.builder(
              itemCount: incomeData.length,
              itemBuilder: (ctx, index) {
                final data = incomeData[index];

                return ListTile(
                  title: data.categoryType == true
                      ? Text(data.categoryName)
                      : Container(),
                  trailing: Wrap(
                    children: [
                      GestureDetector(
                          onTap: () {
                            newBox.delete(keys[index]);
                          },
                          child: Icon(Icons.delete))
                    ],
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//-------------------------------------

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  // title: Text('Add expense category'),
                  content: TextField(
                    controller: incomeController,
                    decoration: InputDecoration(hintText: 'expense category'),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (incomeController.text.isEmpty) {
                            Navigator.pop(context);
                            return;
                          } else {
                            final incomeDetails = categoryModel(
                              categoryName: incomeController.text,
                              categoryType: true,
                            );
                            incomeBox.add(incomeDetails);

                            incomeController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Save'))
                  ],
                );
              });

//-----------------------------------------
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
