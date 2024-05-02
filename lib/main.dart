import 'package:flutter/material.dart';

import 'package:project/pages/Login.dart';
import 'package:project/sidebar/sidebar_layout.dart';

import 'header.dart';

void main() {
  runApp(MaterialApp(home: Myapp()));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primaryColor: Colors.white),
      home: Login(),
    );
  }
}
