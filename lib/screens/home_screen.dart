import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';
import 'package:money_manager_app/screens/add_transactions/add_main_screen.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../functions/functions.dart';
import 'package:intl/intl.dart';

double? totalIncome;
double? totalExpense;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // DateTime monthYear = DateTime.now();

  var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');
  double totalIncome = 0;
  List<int> incomel = [];
  List expensel = [];
  List<String> items = ['monthly', 'yearly'];
  int? _value = 1;
  String? _selectedItem = 'monthly';

  get drpdown => null;

  double incomeSum(List<addExpAndIncModel> list) {
    double incomeTotal = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].transactionType == true) {
        incomeTotal += list[i].amount;
      }
    }
    totalIncome = incomeTotal;
    return incomeTotal;
  }

  double expenseSum(List<addExpAndIncModel> list) {
    double expenseTotal = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].transactionType == false) {
        expenseTotal += list[i].amount;
      }
    }
    totalExpense = expenseTotal;
    return expenseTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 236, 236),
      appBar: AppBar(
        title: Text('Money Manager'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom:
                        BorderSide(color: Color.fromARGB(255, 224, 223, 223)))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),

              child: ValueListenableBuilder(
                  valueListenable: Hive.box<addExpAndIncModel>('transactionBox')
                      .listenable(),
                  builder: (BuildContext ctx, Box<addExpAndIncModel> newBox,
                      Widget? child) {
                    List<addExpAndIncModel> transactionData =
                        newBox.values.toList();
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_back_ios_new_outlined),
                                Text('may 2020'),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                                child: DropdownButton<String>(
                                    items: items
                                        .map((item) => DropdownMenuItem(
                                              child: Text(item),
                                              value: item,
                                            ))
                                        .toList(),
                                    value: _selectedItem,
                                    onChanged: (item) {
                                      setState(() {
                                        _selectedItem = item;
                                      });
                                    }))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // children: [Text('income'), Text(''],
                              children: [
                                Text('income'),
                                // Text(totalIncome.toString()),
                                Text(incomeSum(transactionData).toString())
                              ],
                            ),
                            Column(
                              children: [
                                Text('expense'),
                                Text(expenseSum(transactionData).toString())
                              ],
                            ),
                            Column(
                              children: [
                                Text('total'),
                                Text('${totalIncome - totalExpense!}')
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Column(
                    //       // children: [Text('income'), Text(''],
                    //       children: [
                    //         Text('income'),
                    //         // Text(totalIncome.toString()),
                    //         Text(incomeSum(transactionData).toString())
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [Text('expense'), Text('0')],
                    //     ),
                    //     Column(
                    //       children: [Text('total'), Text('0.00')],
                    //     ),
                    //   ],
                    // ),
                  }),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       // children: [Text('income'), Text(''],
              //       children: [
              //         Text('income'),
              //         // Text(totalIncome.toString()),
              //         Text(incomeSum(transactionData).toString())
              //       ],
              //     ),
              //     Column(
              //       children: [Text('expense'), Text('0')],
              //     ),
              //     Column(
              //       children: [Text('total'), Text('0.00')],
              //     ),
              //   ],
              // ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<addExpAndIncModel>('transactionBox').listenable(),
                builder: (BuildContext ctx, Box<addExpAndIncModel> newBox,
                    Widget? child) {
                  List<addExpAndIncModel> transactionData =
                      newBox.values.toList();

                  List keys = newBox.keys.toList();
                  return ListView.builder(
                      itemCount: transactionData.length,
                      itemBuilder: (context, index) {
                        int reverseIndex = transactionData.length - 1 - index;
                        //---------------------------

                        if (transactionData[reverseIndex].transactionType ==
                            false) {
                          expensel.add(transactionData[reverseIndex].amount);
                        } else if (transactionData[reverseIndex]
                                .transactionType ==
                            true) {
                          incomel.add(transactionData[reverseIndex].amount);
                        }
                        ;

                        //------------------------------------
                        return GestureDetector(
                          onLongPress: () {
                            newBox.delete(keys[reverseIndex]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: transactionData[reverseIndex]
                                          .transactionType ==
                                      false
                                  ? Color.fromARGB(255, 255, 173, 167)
                                  : Color.fromARGB(255, 172, 255, 188),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(DateFormat('dd-MM-yyyy')
                                          .format(transactionData[reverseIndex]
                                              .dateOftransaction)),
                                    ),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text(transactionData[reverseIndex]
                                        .categoryName),
                                    trailing: Text(transactionData[reverseIndex]
                                        .amount
                                        .toString()),
                                  )
                                ],
                                // title: Text(ExpenseAndIncomeList[index].categoryName),
                                // subtitle: Text(ExpenseAndIncomeList[index].amount.toString()),
                                // leading: Text(DateFormat('dd-MM-yyyy').format(ExpenseAndIncomeList[index].dateOftransaction)),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddIncomeAndExpenseScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  double incomeS(List<addExpAndIncModel> list) {
    double incomeTotal = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].transactionType == false) {
        incomeTotal += list[i].amount;
      }
    }
    totalIncome = incomeTotal;
    return incomeTotal;
  }
}
