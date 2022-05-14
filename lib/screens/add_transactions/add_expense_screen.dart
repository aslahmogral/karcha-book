import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/functions/functions.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';
import 'package:money_manager_app/screens/chart_screen/expense_chart_screen.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  var transactionBox =  Hive.box<addExpAndIncModel>('transactionBox');
  var expenseBox = Hive.box<categoryModel>('expenseCategoryBox');

  DateTime date = DateTime.now();
  String? categoryHintText;
  final expenseController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 219, 219),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date'),
                                Flexible(
                                    child: Container(
                                        width: 250,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: DateFormat('dd-MM-yyyy')
                                                  .format(date)),
                                          onTap: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: date,
                                                    firstDate: DateTime(1990),
                                                    lastDate: DateTime(2100));
                                            if (newDate == null) return;
                                            setState(() {
                                              date = newDate;
                                            });
                                          },
                                          readOnly: true,
                                        )))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Category'),
                                Flexible(
                                    child: Container(
                                        width: 250,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: categoryHintText),
                                          readOnly: true,
                                          onTap: () {
                                            bottomSheetOfExpense(context);
                                          },
                                        )))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Amount'),
                                Flexible(
                                    child: Container(
                                        width: 250,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: amountController,
                                        )))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            int amounts = int.parse(amountController.text);
                            final exp = addExpAndIncModel(
                                categoryName: categoryHintText,
                                amount: amounts,
                                dateOftransaction: date,
                                transactionType: false);
                            transactionBox.add(exp);
                            
                            Navigator.pop(context);
                          },
                          child: Text('save')),
                      ElevatedButton(onPressed: () {}, child: Text('Continue'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<dynamic> bottomSheetOfExpense(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Container(
                  height: 50,
                  color: Colors.black,
                  child: Flexible(
                      child: ListTile(
                    trailing: Wrap(
                      children: [
                        GestureDetector(
                          onTap: () {
                            //-------------------------------------

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // title: Text('Add expense category'),
                                    content: TextField(
                                      controller: expenseController,
                                      decoration: InputDecoration(
                                          hintText: 'expense category'),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            // final expeseDetails = categoryModel(
                                            //     categoryName:
                                            //         expenseController.text, transactionType: true);
                                            // addCategory(expeseDetails);
                                            // expenseController.clear();
                                            // Navigator.pop(context);

                                            if (expenseController
                                                .text.isEmpty) {
                                              expenseController.clear();
                                              Navigator.pop(context);
                                              return;
                                            } else {
                                              final expenseDetails =
                                                  categoryModel(
                                                      categoryName:
                                                          expenseController
                                                              .text,
                                                      categoryType: false);

                                              expenseBox.add(
                                                  expenseDetails);
                                              expenseController.clear();
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text('Save'))
                                    ],
                                  );
                                });

                            //--------------------------------------
                          },
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, color: Colors.white),
                        )
                      ],
                    ),
                  ))),
              ValueListenableBuilder(
                  valueListenable: Hive.box<categoryModel>('expenseCategoryBox').listenable(),
                  builder: (BuildContext ctx,
                      Box<categoryModel> newBox, Widget? child) {

                         List<categoryModel> expenseData = newBox.values.toList();
                    return ListView.builder(
                        itemCount: expenseData.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                categoryHintText =
                                    expenseData[index].categoryName;
                              });
                              Navigator.pop(context);
                            },
                            title:
                                Text(expenseData[index].categoryName),
                          );
                        });
                  })
            ],
          );
        });
  }
}
