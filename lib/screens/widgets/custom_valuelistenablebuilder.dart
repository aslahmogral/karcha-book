import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/moneymanagermodel.dart';

class CustomValuelistenableBuilder extends StatelessWidget {
  final String boxName;
  final bool categoryType;
  final customFunction;
  final bool? isTransactionType;

  const CustomValuelistenableBuilder({
    Key? key,
    required this.boxName,
    required this.categoryType,
    this.customFunction,
    this.isTransactionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<categoryModel>(boxName).listenable(),
      builder: (BuildContext ctx, Box<categoryModel> newBox, Widget? child) {
        List<categoryModel> categoryData = newBox.values.toList();
        List keys = newBox.keys.toList();
        return ListView.separated(
          itemCount: categoryData.length,
          itemBuilder: (ctx, index) {
            final data = categoryData[index];

            return ListTile(
              onTap: (() {
                if (isTransactionType == true) {
                  customFunction(categoryData[index].categoryName);
                  Navigator.pop(context);
                } else {
                  return;
                }
              }),
              title: data.categoryType == categoryType
                  ? Text(data.categoryName)
                  : Container(),
              trailing: Wrap(
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: GestureDetector(
                          onTap: () {
                            newBox.delete(keys[index]);
                          },
                          child: Icon(Icons.delete)))
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        );
      },
    );
  }
}
