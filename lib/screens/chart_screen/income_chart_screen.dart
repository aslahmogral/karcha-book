import 'package:flutter/material.dart';

class IncomeChartScreen extends StatefulWidget {
  const IncomeChartScreen({ Key? key }) : super(key: key);

  @override
  State<IncomeChartScreen> createState() => IncomeChartScreenState();
}

class IncomeChartScreenState extends State<IncomeChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Income Chart Screen')),
    );
  }
}