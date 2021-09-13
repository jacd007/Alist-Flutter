import 'package:alistvideos/common/Utils.dart';
import 'package:flutter/material.dart';

class UtilsWidget {
  //appBar
  static AppBar appBar({
    required String title,
    required Function() onPressed,
    double elevation = 4.0,
    bool enabledBtnBack = true,
    Color? colorBG,
    Color colorText = Colors.white,
    PreferredSizeWidget? botton,
    List<Widget>? actions,
  }) =>
      AppBar(
        elevation: elevation,
        actions: actions,
        leading: enabledBtnBack
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios, color: colorText),
                onPressed: onPressed,
              )
            : SizedBox(),
        centerTitle: true,
        backgroundColor: colorBG ?? colorPrimary,
        title: Text(
          title,
          style: TextStyle(
            letterSpacing: 2.0,
            fontFamily: 'Bebas',
            color: colorText,
          ),
        ),
        bottom: botton,
      );

  //Button generic
  static Widget buttonGeneric({
    String text = '',
    Color colorBtn = Colors.blue,
    Color colorText = Colors.white,
    EdgeInsets padding = EdgeInsets.zero,
    @required Function()? onClicks,
  }) {
    return Padding(
      padding: padding,
      child: MaterialButton(
        color: colorBtn,
        child: Text(
          '$text',
          style: TextStyle(color: colorText),
        ),
        onPressed: onClicks,
      ),
    );
  }

  //EditText With Text row
  static Widget editTextRowTitle(
      {String title = '',
      TextEditingController? controller,
      double wt = 100,
      double ht = 50,
      double wet = 100,
      double het = 50,
      String Function(String?)? validator,
      EdgeInsets padding = EdgeInsets.zero}) {
    return Container(
      padding: padding,
      child: Row(
        children: [
          Container(
            width: wt,
            height: ht,
            child: Text('$title'),
          ),
          Container(
              width: wet,
              height: het,
              child: TextFormField(
                controller: controller,
                validator: validator,
              )),
        ],
      ),
    );
  }
}
