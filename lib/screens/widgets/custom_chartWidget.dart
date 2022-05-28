
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// import '../../model/moneymanagermodel.dart';

// class CustomChartWidget extends StatelessWidget {
//   final 
//    CustomChartWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    
//   var transactionBox = Hive.box<addExpAndIncModel>('transactionBox');
//   var incomeBox = Hive.box<categoryModel>('incomeCategoryBox');
//   var expenseBox = Hive.box<categoryModel>('expenseCategoryBox');
//   Map<String, double> map2 = {};
    
//     return Column(
//       children: [
//         Card(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                   child: PieChart(
//                 dataMap: map2,
//                 colorList: randomColorList(incomeBox),
//                 chartRadius: MediaQuery.of(context).size.width / 2,
//               )),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Container(
//             child: ValueListenableBuilder(
//                 valueListenable:
//                     Hive.box<addExpAndIncModel>('transactionBox').listenable(),
//                 builder: (BuildContext context, Box<addExpAndIncModel> newBox,
//                     Widget? child) {
//                   List<Total> incomeList = getTotalIncome(newBox, incomeBox);
//                   return ListView.builder(
//                       itemCount: incomeList.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(incomeList[index].categoryName),
//                           trailing: Text(incomeList[index].total.toString()),
//                           leading: RichText(
//                               text: TextSpan(
//                             text:
//                                 '${incomeList[index].percentage.toStringAsFixed(2)}%',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                             ),
//                           )),
//                         );
//                       });
//                 }),
//           ),
//         )
//       ],
//     );


//   }
// }