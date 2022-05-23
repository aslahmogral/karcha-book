import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';

import '../widgets/custom_valuelistenablebuilder.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({Key? key}) : super(key: key);

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  var incomeBox = Hive.box<categoryModel>('incomeCategoryBox');
  var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');

  ValueNotifier<String> categoryHintText = ValueNotifier('');
  bool isTransactionPage = true;
  void changeHintText(newString) {
    categoryHintText.value = newString;
  }

  DateTime date = DateTime.now();
  final incomeController = TextEditingController();
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
                                          readOnly: true,
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
                                          decoration: InputDecoration(
                                            hintText: DateFormat('dd-MM-yyyy')
                                                .format(date),
                                          ),
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
                                          controller: incomeController,
                                          decoration: InputDecoration(
                                              hintText: categoryHintText.value),
                                          readOnly: true,
                                          onTap: () {
                                            bottomSheetOfIncome(context);
                                          },
                                        );
                                      },
                                    ),
                                ))
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
                            final inc = addExpAndIncModel(
                                categoryName: categoryHintText.value,
                                amount: amounts,
                                dateOftransaction: date,
                                transactionType: true);
                            transactionBox.add(inc);

                            Navigator.pop(context);
                          },
                          child: Text('save')),
                      ElevatedButton(onPressed: () {

                      }, child: Text('Continue'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

//---------------------

  Future<dynamic> bottomSheetOfIncome(BuildContext context) {
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
                                      controller: incomeController,
                                      decoration: InputDecoration(
                                          hintText: 'income category'),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            //--------------

                                            if (incomeController.text.isEmpty) {
                                              incomeController.clear();
                                              Navigator.pop(context);
                                              return;
                                            } else {
                                              final incomeDetails =
                                                  categoryModel(
                                                categoryName:
                                                    incomeController.text,
                                                categoryType: true,
                                              );

                                              incomeBox.add(incomeDetails);

                                              incomeController.clear();
                                              Navigator.pop(context);
                                            }

                                            //-----------------
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
               Expanded(
                child: CustomValuelistenableBuilder(boxName:'incomeCategoryBox' , categoryType: true,customFunction:changeHintText ,isTransactionType: true,)
              )
            ],
          );
        });
  }
}




//-----------------------------
 




