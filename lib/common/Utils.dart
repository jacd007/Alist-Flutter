// ignore: unused_import
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//nomnbre de la app
// ignore: non_constant_identifier_names
final String APP_NAME = 'AList Videos';

//COLORES
final Color colorPrimary = Color(0xFF000852);

/*
//-----para salir de la app
SystemChannels.platform.invokeMethod('SystemNavigator.pop');

para abrir drawer (previo key)
onPressed: () => _scaffoldKey.currentState.openDrawer(),
//- key
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


//-----para quitar barra de estado de notificaciones
SystemChrome.setEnabledSystemUIOverlays([])

//-----para poner barra de estado de notificaciones
SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values)

*/

class Utils {
  static toast(String msg, {int? duration, int? gravity}) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static toastError(String msg, {int? duration, int? gravity}) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static dialogList({
    required BuildContext context,
    required List<String> list,
    required String title,
    required Function(String) onclick,
    Color? mColor,
    String? image,
    double w = 300.0,
    double h = 300.0,
  }) {
    showDialog(
        context: context,
        routeSettings: RouteSettings(name: 'dialogList'),
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$title'),
            content: Container(
              height: h, // Change as per your requirement
              width: w, // Change as per your requirement
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: onclick(list[i]) ?? () {},
                    child: Container(
                      color: (i % 2 == 0) ? Colors.grey[100] : Colors.grey[200],
                      child: ListTile(
                        title: Text('${list[i]}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  static dialogMessage({
    required BuildContext context,
    required String message,
    required String title,
    required Function() onclick,
    Color? mColor,
    String? image,
    double width = 300.0,
    double height = 300.0,
  }) {
    showDialog(
        context: context,
        routeSettings: RouteSettings(name: 'dialogList'),
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$title'),
            content: Container(
              height: height, // Change as per your requirement
              width: width, // Change as per your requirement
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: Text(message))),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                          child: Text('Aceptar'),
                          onPressed: () {
                            onclick();
                            Navigator.pop(context);
                          }),
                      MaterialButton(
                          child: Text('Cancelar'),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  //--------- toast times
  // ignore: non_constant_identifier_names
  static final TOAST_LONG = Toast.LENGTH_LONG;
  // ignore: non_constant_identifier_names
  static final TOAST_SHORT = Toast.LENGTH_SHORT;
}
