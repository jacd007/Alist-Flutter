import 'package:alistvideos/view/All.dart';
import 'package:alistvideos/view/Edit.dart';
import 'package:alistvideos/view/Home.dart';
import 'package:flutter/material.dart';

import 'package:alistvideos/common/Utils.dart' as u;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: u.APP_NAME,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/editvideo': (context) => EditPage(),
        '/all': (context) => AllPage(),
      },
    );
  }
}
