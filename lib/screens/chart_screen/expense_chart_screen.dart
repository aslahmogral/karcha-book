import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_app/model/total.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../model/moneymanagermodel.dart';

class ExpenseChartScreen extends StatefulWidget {
  ExpenseChartScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseChartScreen> createState() => _ExpenseChartScreenState();
}

class _ExpenseChartScreenState extends State<ExpenseChartScreen> {
//---------------------------------

  var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');
  var incomeBox = Hive.box<categoryModel>('incomeCategoryBox');
  var expenseBox = Hive.box<categoryModel>('expenseCategoryBox');
  List<Total> totalExpense = [];

  // getTotal(Box<addExpAndIncModel> newBox) {
  //   List<addExpAndIncModel> boxList = newBox.values.toList();
  //   for (int i = 1; i <= incomeBox.length; i++) {
  //     double ExpenseTransactionLenght = 0;
  //     double IncomeTransactionLenght = 0;

  //     for (int j = 0; j < boxList.length; j++) {
  //       if (boxList[j].categoryType == false) {
  //         ExpenseTransactionLenght++;
  //       } else {
  //         IncomeTransactionLenght++;
  //       }
  //     }
  //     print(ExpenseTransactionLenght);
  //     print(IncomeTransactionLenght);

  //     // ;
  //   }
  //   // return TotalIncCount;
  // }

  //find the total of income category separately
  List<Total> getTotalIncome(
      Box<addExpAndIncModel> newBox, Box<categoryModel> newBox2) {
    List<addExpAndIncModel> boxList = newBox.values.toList();
    List<categoryModel> boxList2 = newBox2.values.toList();
    List<Total> totalOfCategory = [];

    print('this is boxList2 length ${boxList2.length}');
    print(boxList[1].categoryType);

    for (int i = 0; i < boxList2.length; i++) {
      print('this is boxList[i].categoryType ${boxList[i].categoryType}');
      // print(boxList[0].amount);
      // print(boxList2[1].categoryName);
      double totalCategoryCount = 0;

      if (boxList2[i].categoryType == true) {
        print('this is true');
        for (int j = 0; j < boxList.length; j++) {
          if (boxList2[i].categoryName == boxList[j].categoryName) {
            totalCategoryCount += boxList[j].amount;
          }
          print(totalCategoryCount);
          //add total of each category to totalOfCategory
         
        }
         totalOfCategory.add(Total(
              categoryName: boxList2[i].categoryName, total: totalCategoryCount));
              print(totalOfCategory);
      } else {
        print('this is false');
      }
      

      // if (boxList[i].categoryType == false ) {
      //   for (int j = 0; j < boxList.length; j++) {

      //     if (boxList2[i].categoryName == boxList[j].categoryName) {
      //       totalCategoryCount += boxList[j].amount;
      //       print(totalCategoryCount);
      //     }
      //   }
      // }

      // totalOfCategory.add(Total(
      //     categoryName: boxList2[i].categoryName, total: totalCategoryCount));
    }
    return totalOfCategory;
  }

//-----------------------------------

  // List<Total> getGdpDataExpense(List<addExpAndIncModel> transactions) {
  //   final List<Total> charDataExpense = [];
  //   List<categoryModel> catList = incomeBox.values.toList();
  //   for (int i = 0; i < catList.length; i++) {
  //     double amount = 0;
  //     if (catList[i].transactionType == false) {
  //       for (int j = 0; j < transactions.length; j++) {
  //         if (catList[i].categoryName == transactions[j].category) {
  //           amount += transactions[j].amount;
  //         }
  //       }
  //       if (amount != 0) {
  //         var percentage =
  //             ((amount.roundToDouble() / expenseSum(firstFilterList)) * 100)
  //                 .toStringAsFixed(2);
  //         charDataExpense.add(GDPData(
  //             catList[i].categoryName, amount.round(), '$percentage %'));
  //       }
  //     }
  //   }
  //   return charDataExpense;
  // }

//-----------------------------------

  
  Map<String, double> dataMap = {
    "food Items": 20,
    "dress": 20,
    "book": 20,
    "education": 20,
    "clock": 20
  };

  List<Color> colorList = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: PieChart(
                dataMap: dataMap,
                colorList: colorList,
                chartRadius: MediaQuery.of(context).size.width / 2,
              ))
              //   child: Container(
              //     height: 200,
              //     width: 200,
              //     child: PieChart(PieChartData(
              //       borderData: FlBorderData(show: false),
              //       sectionsSpace: 0,
              //       centerSpaceRadius: 40,
              //       sections: getSection(),
              //     )),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Column(
              //       // children: PieData.data.map((Data) => ).toList(),
              //       children: [
              //         ElevatedButton(
              //             onPressed: () {
              //               print(PieData.data.toList());
              //             },
              //             child: Text('click me'))
              //       ],
              //     )
              //   ],
              // )
              ,
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<addExpAndIncModel>('transactionBox').listenable(),
                builder: (BuildContext context, Box<addExpAndIncModel> newBox,
                    Widget? child) {
                  List<Total> incomeList = getTotalIncome(newBox, incomeBox);
                  return ListView.builder(
                      itemCount: incomeList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(incomeList[index].categoryName),
                          trailing: Text(incomeList[index].total.toString()),
                        );
                      });
                }),
          ),
        )
      ],
    );
  }
}
