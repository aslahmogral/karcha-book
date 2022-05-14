import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  List IconsOfSettings = [
    Icons.notifications,
    Icons.restart_alt,
    Icons.share
    ,Icons.reviews
    ,Icons.forum
    ,Icons.policy
    ,Icons.person

  ];
  List namesOfSettings = [
    'Notifications',
    'Reset Everything',
    'Share',
    'Write a Review',
    'Feedback',
    'Privacy Policy',
    'About us'
  ];

  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(IconsOfSettings[index]),
              title: Text(namesOfSettings[index]),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: namesOfSettings.length),
    );
  }
}
