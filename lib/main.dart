import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager_app/screens/bottom_navigation_screen.dart';

import 'model/moneymanagermodel.dart';

const colorP = const Color(0xFFB74093);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(addExpAndIncModelAdapter());
  Hive.registerAdapter(categoryModelAdapter());
  //created three boxes of hive
  // 1- expense category
  // 2- income category
  // 3- transaction
  await Hive.openBox<categoryModel>('expenseCategoryBox');
  await Hive.openBox<categoryModel>('incomeCategoryBox');
  await Hive.openBox<addExpAndIncModel>('transactionBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color(0xff004bac),
              ),
        ),
        home: BottomNavigation());
  }
}
