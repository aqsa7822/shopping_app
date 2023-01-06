import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/widgets.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar(context, "Notifications"),
      body: Container(
        child: const Text("Notification page"),
      ),
    );
  }
}
