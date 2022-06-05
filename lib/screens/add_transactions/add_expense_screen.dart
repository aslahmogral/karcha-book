import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/screens/widgets/custom_dialogbox.dart';
import 'package:money_manager_app/screens/widgets/custom_valuelistenablebuilder.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');
  var expenseBox = Hive.box<categoryModel>('expenseCategoryBox');
  ValueNotifier<String> categoryHintText = ValueNotifier('');
  DateTime date = DateTime.now();
  TextEditingController expenseController = TextEditingController();
  final amountController = TextEditingController();
  bool isTransactionPage = true;
  void changeHintText(newString) {
    categoryHintText.value = newString;
  }

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
                                    child: ValueListenableBuilder(
                                      valueListenable: categoryHintText,
                                      builder: (BuildContext context,
                                          String newValue, Widget? child) {
                                        return TextField(
                                          controller: expenseController,
                                          decoration: InputDecoration(
                                              hintText: categoryHintText.value),
                                          readOnly: true,
                                          onTap: () {
                                            bottomSheetOfExpense(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
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
                      Container(
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              
                              int amounts = int.parse(amountController.text);
                              final exp = addExpAndIncModel(
                                  categoryName: categoryHintText.value,
                                  amount: amounts,
                                  dateOftransaction: date,
                                  transactionType: false);
                              transactionBox.add(exp);

                              Navigator.pop(context);
                            },
                            child: Text('Save'),),
                      ),
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
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                      controller: expenseController,
                                      box: expenseBox,
                                      transactionType: false);
                                });
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
              Expanded(
                  child: CustomValuelistenableBuilder(
                boxName: 'expenseCategoryBox',
                categoryType: false,
                customFunction: changeHintText,
                isTransactionType: true,
              ))
            ],
          );
        });
  }
}
