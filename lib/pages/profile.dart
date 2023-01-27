import 'package:flutter/material.dart';
import 'package:shopping_app/constants/constants.dart';

import '../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  String email;
  String name;
  String address;
  int phoneNumber;
  ProfilePage(
      {Key? key,
      required this.email,
      required this.name,
      required this.address,
      required this.phoneNumber})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(context, "Profile"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Constants().fieldColor),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Image.asset("assets/user.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            fieldContainer(
                context, "Email: ${widget.email}", Constants().fieldColor, Colors.grey),
            SizedBox(
              height: 10,
            ),
            fieldContainer(context, "Phone: +92-${widget.phoneNumber}",
                Constants().fieldColor, Colors.grey),
            SizedBox(
              height: 10,
            ),
            fieldContainer(
                context, "Address: ${widget.address}", Constants().fieldColor, Colors.grey),
          ],
        ),
      ),
    );
  }
}
