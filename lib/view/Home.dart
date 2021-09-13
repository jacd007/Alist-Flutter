import 'package:alistvideos/common/Utils.dart';
import 'package:alistvideos/common/UtilsWidget.dart';
import 'package:alistvideos/data/db.dart';
import 'package:alistvideos/view/All.dart';
import 'package:alistvideos/view/Edit.dart';
import 'package:alistvideos/view/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final bool? login;

  HomePage({this.login});

  @override
  _HomePageState createState() => _HomePageState(isLogin: this.login);
}

class _HomePageState extends State<HomePage> {
  bool? isLogin;
  int _currentIndex = 1;
  // ignore: unused_field
  String _data = '';
  // ignore: unused_field
  final _listTitleAppBar = [
    'Nuevo',
    'Todos',
    'Pendientes',
    'Historial',
    'Perfil'
  ];

  //String _titleAppBar = '';

  _HomePageState({this.isLogin});

  final tabs = [
    EditPage(),
    AllPage(),
    Center(
      child: Text('Pendientes'),
    ),
    Center(
      child: Text('Historial'),
    ),
    Center(
      child: Text('Perfil'),
    ),
    //ProfilePage(),
  ];

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print('Cerrando sesión.');

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: UtilsWidget.appBar(
          title: APP_NAME,
          onPressed: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorPrimary,
          selectedItemColor: Colors.green,
          selectedIconTheme: IconThemeData(color: Colors.green),
          selectedLabelStyle: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
          unselectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: Colors.white),
          unselectedLabelStyle:
              TextStyle(fontSize: 14.0, color: Colors.blueGrey),
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: _listTitleAppBar[0],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.clear_all_sharp),
              label: _listTitleAppBar[1],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions_outlined),
              label: _listTitleAppBar[2],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: _listTitleAppBar[3],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: _listTitleAppBar[4],
            ),
          ],
          onTap: (index) {
            setState(() {
              DB.videos();
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
