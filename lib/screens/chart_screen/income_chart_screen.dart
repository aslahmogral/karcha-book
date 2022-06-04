import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_app/model/total.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../model/moneymanagermodel.dart';

double totalincome = 0;

class IncomeChartScreen extends StatefulWidget {
  IncomeChartScreen({Key? key}) : super(key: key);

  @override
  State<IncomeChartScreen> createState() => _IncomeChartScreennState();
}

class _IncomeChartScreennState extends State<IncomeChartScreen> {
//---------------------------------

  var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');
  var incomeBox = Hive.box<categoryModel>('incomeCategoryBox');
  var expenseBox = Hive.box<categoryModel>('expenseCategoryBox');
  Map<String, double> map2 = {};

  List<Total> totalExpense = [];

  List<Total> getTotalIncome(
      Box<addExpAndIncModel> newBox, Box<categoryModel> categoryBox) {
    List<addExpAndIncModel> boxList = newBox.values.toList();
    List<categoryModel> categoryList = categoryBox.values.toList();
    List<Total> totalOfCategory = [];

    double totalOfincome = incomeSum(boxList);

    for (int i = 0; i < categoryList.length; i++) {
      double amount = 0;

      if (categoryList[i].categoryType == true) {
        for (int j = 0; j < boxList.length; j++) {
          if (categoryList[i].categoryName == boxList[j].categoryName) {
            amount += boxList[j].amount;
          }
        }

        if (amount != 0) {
          var percentage = ((amount.roundToDouble() / totalOfincome) * 100);

          totalOfCategory.add(Total(
            categoryName: categoryList[i].categoryName,
            total: amount,
            percentage: percentage,
          ));
        }
      }
    }
    return totalOfCategory;
  }

// totalOfCateegory

  double incomeSum(List<addExpAndIncModel> list) {
    double incomeTotal = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].transactionType == true) {
        incomeTotal += list[i].amount;
      }
    }
    // totalIncome = incomeTotal;
    return incomeTotal;
  }

  // convert

  // generate random color list for pie chart
  List<Color> randomColorList(Box<categoryModel> colorBox) {
    List<Color> colorList = [];
    for (int i = 0; i < colorBox.length; i++) {
      colorList
          .add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    }
    return colorList;
  }

  @override
  Widget build(BuildContext context) {
    List<Total> totalOfChart = getTotalIncome(transactionBox, incomeBox);
    totalOfChart
        .forEach((Total) => map2[Total.categoryName] = Total.percentage);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            // add width to container
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: PieChart(
                    dataMap: map2,
                    colorList: randomColorList(incomeBox),
                    chartRadius: MediaQuery.of(context).size.width / 2,
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 194, 190),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ValueListenableBuilder(
                  valueListenable: Hive.box<addExpAndIncModel>('transactionBox')
                      .listenable(),
                  builder: (BuildContext context, Box<addExpAndIncModel> newBox,
                      Widget? child) {
                    List<Total> incomeList = getTotalIncome(newBox, incomeBox);
                    return ListView.separated(
                      itemCount: incomeList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(incomeList[index].categoryName),
                          trailing: Text(incomeList[index].total.toString()),
                          leading: RichText(
                              text: TextSpan(
                            text:
                                '${incomeList[index].percentage.toStringAsFixed(2)}%',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          )),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.white,
                          thickness: 1.5,
                        );
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
