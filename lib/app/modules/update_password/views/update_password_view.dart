import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
        centerTitle: true,
      ),
      body: ListView(padding: EdgeInsets.all(20), children: [
        SizedBox(
          height: 15,
        ),
        TextField(
          readOnly: true,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: "Password Lama",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          readOnly: true,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: "Password Baru",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Update Password'),
        ),
      ]),
    );
  }
}
