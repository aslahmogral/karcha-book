import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');
  double totalIncome = 0;
  List<int> incomel = [];
  List expensel = [];
  List<String> items = ['monthly', 'yearly'];
  String? selectedItem = 'monthly';
  DateTime monthYearNow = DateTime.now();
  final DateFormat monthFormat = DateFormat("MMM yyyy");
  final DateFormat yearFormat = DateFormat("yyyy");

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
                                IconButton(
                                    onPressed: () {
                                      if (selectedItem == 'monthly') {
                                        monthYearNow = DateTime(
                                            monthYearNow.year,
                                            monthYearNow.month - 1);
                                        setState(() {});
                                      } else if (selectedItem == 'yearly') {
                                        monthYearNow = DateTime(
                                            monthYearNow.year - 1,
                                            monthYearNow.month);
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(Icons.arrow_back)),
                                Text(selectedItem == 'monthly'
                                    ? monthFormat.format(monthYearNow)
                                    : yearFormat.format(monthYearNow)),
                                IconButton(
                                    onPressed: () {
                                      if (selectedItem == 'monthly') {
                                        monthYearNow = DateTime(
                                            monthYearNow.year,
                                            monthYearNow.month + 1);
                                        setState(() {});
                                      } else if (selectedItem == 'yearly') {
                                        monthYearNow = DateTime(
                                            monthYearNow.year + 1,
                                            monthYearNow.month);
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(Icons.arrow_forward)),
                              ],
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue)),
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
                                    }))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('income'),
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
                  }),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<addExpAndIncModel>('transactionBox').listenable(),
                builder: (BuildContext ctx, Box<addExpAndIncModel> newBox,
                    Widget? child) {
                  List<addExpAndIncModel> sortedData = selectedItem == 'monthly'
                      ? filteredList(newBox)[0]
                      : filteredList(newBox)[1];

                  sortedData = sortedData.reversed.toList();

                  List keys = newBox.keys.toList();
                  keys = keys.reversed.toList();
                  return ListView.builder(
                      itemCount: sortedData.length,
                      itemBuilder: (context, index) {

                        if (sortedData[index].transactionType == false) {
                          expensel.add(sortedData[index].amount);
                        } else if (sortedData[index].transactionType == true) {
                          incomel.add(sortedData[index].amount);
                        }
                        ;

                        return GestureDetector(
                          onLongPress: () {
                            newBox.delete(keys[index]);
                          },
                          child: sortedData.isEmpty
                              ? Center(
                                  child: Text('no transaction'),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: sortedData[index].transactionType ==
                                            false
                                        ? Color.fromARGB(255, 255, 173, 167)
                                        : Color.fromARGB(255, 172, 255, 188),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Text(DateFormat('dd-MM-yyyy')
                                                .format(sortedData[index]
                                                    .dateOftransaction)),
                                          ),
                                        ),
                                        Divider(),
                                        ListTile(
                                          title: Text(
                                              sortedData[index].categoryName),
                                          trailing: Text(sortedData[index]
                                              .amount
                                              .toString()),
                                        )
                                      ],
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
