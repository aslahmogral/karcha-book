import 'package:flutter/material.dart';
import 'package:money_manager_app/model/moneymanagermodel.dart';

class CustomDialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final box;
  final bool transactionType;
  CustomDialogBox({
    Key? key,
    required this.controller,
    required this.box,
    required this.transactionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void add() {
      if (controller!.text.isEmpty) {
        Navigator.pop(context);
        return;
      } else {
        final transactionDetails = categoryModel(
          categoryName: controller!.text,
          categoryType: transactionType,
        );
        box.add(transactionDetails);

        controller!.clear();
        Navigator.pop(context);
      }
    }

    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'expense category'),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              add();
            },
            child: Text('Save'))
      ],
    );
  }
}
