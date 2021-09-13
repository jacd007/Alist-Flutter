import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ESTO ES EL LOGIN'),
        ),
        body: Center(
          child: Container(
            child: Text('LOGIN'),
          ),
        ),
      ),
    );
  }
}
