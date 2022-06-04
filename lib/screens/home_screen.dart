import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/data/piedata.dart';
import 'package:money_manager_app/functions/functions.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';
import 'package:money_manager_app/screens/add_transactions/add_main_screen.dart';

import 'package:intl/intl.dart';

double? totalIncome;
double? totalExpense;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showFab = false;
  ScrollController scrollController = ScrollController();
  var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');
  double totalIncome = 0;
  List<int> incomel = [];
  List expensel = [];
  List<String> items = ['Monthly', 'Yearly'];
  String? selectedItem = 'Monthly';
  DateTime monthYearNow = DateTime.now();
  final DateFormat monthFormat = DateFormat("MMM yyyy");
  final DateFormat yearFormat = DateFormat("yyyy");

  void initstate() {
    super.initState();
    scrollController = ScrollController();
  }

  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 237, 236, 236),
        appBar: AppBar(
          backgroundColor: Color(0xff004bac),
          title: Text('Karcha Book'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 224, 223, 223)))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<addExpAndIncModel>('transactionBox')
                            .listenable(),
                    builder: (BuildContext ctx, Box<addExpAndIncModel> newBox,
                        Widget? child) {
                      List<addExpAndIncModel> sortedData =
                          selectedItem == 'Monthly'
                              ? filteredList(newBox)[0]
                              : filteredList(newBox)[1];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (selectedItem == 'Monthly') {
                                          monthYearNow = DateTime(
                                              monthYearNow.year,
                                              monthYearNow.month - 1);
                                          setState(() {});
                                        } else if (selectedItem == 'Yearly') {
                                          monthYearNow = DateTime(
                                              monthYearNow.year - 1,
                                              monthYearNow.month);
                                          setState(() {});
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Color(0xff004bac),
                                      )),
                                  Text(selectedItem == 'Monthly'
                                      ? monthFormat.format(monthYearNow)
                                      : yearFormat.format(monthYearNow)),
                                  IconButton(
                                      onPressed: () {
                                        if (selectedItem == 'Monthly') {
                                          monthYearNow = DateTime(
                                              monthYearNow.year,
                                              monthYearNow.month + 1);
                                          setState(() {});
                                        } else if (selectedItem == 'Yearly') {
                                          monthYearNow = DateTime(
                                              monthYearNow.year + 1,
                                              monthYearNow.month);
                                          setState(() {});
                                        }
                                      },
                                      icon: Icon(Icons.arrow_forward_ios,
                                          color: Color(0xff004bac))),
                                ],
                              ),
                              Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff004bac)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          items: items
                                              .map((item) => DropdownMenuItem(
                                                    child: Text(item),
                                                    value: item,
                                                  ))
                                              .toList(),
                                          value: selectedItem,
                                          onChanged: (item) {
                                            setState(() {
                                              selectedItem = item;
                                            });
                                          }),
                                    ),
                                  ))
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                  ),
                                  Text(
                                    '\u{20B9}${incomeSum(sortedData).toString()}',
                                    style: TextStyle(color: Colors.green[800]),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Expense',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15)),
                                  Text(
                                    '\u{20B9}${expenseSum(sortedData).toString()}',
                                    style: TextStyle(color: Colors.red[800]),
                                  )
                                ],

                                //'\u{20B9}${your amount}'
                              ),
                              Column(
                                children: [
                                  Text('Total',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15)),
                                  Text('\u{20B9}${totalIncome - totalExpense!}')
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: Hive.box<addExpAndIncModel>('transactionBox')
                      .listenable(),
                  builder: (BuildContext ctx, Box<addExpAndIncModel> newBox,
                      Widget? child) {
                    List<addExpAndIncModel> sortedData =
                        selectedItem == 'monthly'
                            ? filteredList(newBox)[0]
                            : filteredList(newBox)[1];

                    sortedData = sortedData.reversed.toList();

                    List keys = newBox.keys.toList();
                    keys = keys.reversed.toList();
                    return NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        setState(() {
                          if (notification.direction ==
                              ScrollDirection.forward) {
                            showFab = true;
                          } else if (notification.direction ==
                              ScrollDirection.reverse) {
                            showFab = false;
                          }
                        });

                        return true;
                      },
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: sortedData.length,
                          itemBuilder: (context, index) {
                            if (sortedData[index].transactionType == false) {
                              expensel.add(sortedData[index].amount);
                            } else if (sortedData[index].transactionType ==
                                true) {
                              incomel.add(sortedData[index].amount);
                            }
                            ;

                            return GestureDetector(
                              onLongPress: () {
                                AlertDialog(
                                  content: Text(
                                      'Are you sure you want to delete this transaction?'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                         newBox.delete(keys[index]);
                                        },
                                        child: Text('Confirm Delete'))
                                  ],
                                );
                                
                              },
                              child: sortedData.isEmpty
                                  ? Center(
                                      child: Text('no transaction'),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: sortedData[index]
                                                        .transactionType ==
                                                    false
                                                ? Color.fromARGB(255, 209, 2, 2)
                                                : Color.fromARGB(
                                                    255, 0, 162, 33),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    Color(0xff004bac),
                                                radius: 30,
                                                child: Text(
                                                    sortedData[index]
                                                        .categoryName[0]
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                              ),
                                              title: Text(
                                                sortedData[index].categoryName,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              subtitle: Text(
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(sortedData[index]
                                                          .dateOftransaction)),
                                              trailing: Text(
                                                '\u{20B9}${sortedData[index].amount.toString()}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: sortedData[index]
                                                                .transactionType ==
                                                            false
                                                        ? Color.fromARGB(
                                                            255, 209, 2, 2)
                                                        : Color.fromARGB(
                                                            255, 0, 162, 33)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          }),
                    );
                  }),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton.extended(
            backgroundColor: KarchaFabcolor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddIncomeAndExpenseScreen()));
            },
            icon: Icon(Icons.add),
            label: Text('Add transaction'),
          ),
        ));
  }

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

  List<List<addExpAndIncModel>> filteredList(Box<addExpAndIncModel> transBox) {
    List<addExpAndIncModel> filterdByMonth = [];
    List<addExpAndIncModel> filterdByYear = [];
    List<List<addExpAndIncModel>> filterdByYearAndMonth = [
      filterdByMonth,
      filterdByYear
    ];

    List<addExpAndIncModel> boxList = transBox.values.toList();
    for (int i = 0; i < boxList.length; i++) {
      if (boxList[i].dateOftransaction.year == monthYearNow.year) {
        filterdByYear.add(boxList[i]);
        if (boxList[i].dateOftransaction.month == monthYearNow.month) {
          filterdByMonth.add(boxList[i]);
        }
      }
    }

    return filterdByYearAndMonth;
  }
}
