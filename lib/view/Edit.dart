import 'dart:convert';
import 'dart:io';

import 'package:alistvideos/common/Utils.dart';
import 'package:alistvideos/common/UtilsWidget.dart';
import 'package:alistvideos/data/db.dart';
import 'package:alistvideos/model/VideoModel.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = new GlobalKey<FormState>();

  File? _imagen;

  final _picker = ImagePicker();

  SharedPreferences? prefs;

  final _ctr_name = TextEditingController();

  final _ctr_cap = TextEditingController();

  final _ctr_date = TextEditingController();

  final _ctr_day = TextEditingController();

  final _ctr_image = TextEditingController();

  String _dateParsse() =>
      '${DateTime.now().day < 10 ? "0${DateTime.now().day}" : "${DateTime.now().day}"}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour > 12 ? "PM" : "AM"}';

  Future selImagen(op) async {
    var _pickedFile;

    try {
      _pickedFile = await _picker.getImage(
          source: op == 1 ? ImageSource.camera : ImageSource.gallery);

      if (_pickedFile != null) {
        setState(() {
          _imagen = File(_pickedFile.path);
          _saveImageB64(_imagen);
        });
      } else {
        print('No selecciono una foto');
      }
    } catch (e) {
      print(e);
      Utils.toast('Ocurrio un error al traer la imagen');
    }
  }

  _saveImageB64(final fileData) {
    List<int> imageBytes = fileData.readAsBytesSync();
    //print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  @override
  Widget build(BuildContext context) {
    _ctr_date.text = _dateParsse();
    return Scaffold(
        body: Container(
      //color: Colors.black,
      child: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            // new line
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //image
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: _imagen != null
                        ? Image.file(
                            _imagen!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.fill,
                          )),
                UtilsWidget.buttonGeneric(
                  text: 'Cambiar imagen',
                  padding: EdgeInsets.all(8.0),
                  onClicks: () {
                    print('Cambiando imagen');
                    selImagen(2);
                  },
                ),
                UtilsWidget.editTextRowTitle(
                  title: 'Nombre:',
                  ht: 30,
                  het: 30,
                  wt: MediaQuery.of(context).size.width * (0.15),
                  wet: MediaQuery.of(context).size.width * (0.8),
                  padding: EdgeInsets.all(8.0),
                  controller: _ctr_name,
                  validator: (value) =>
                      value!.isEmpty ? 'Nombre es requerido' : '',
                ),
                UtilsWidget.editTextRowTitle(
                  title: 'Capitulo:',
                  ht: 30,
                  het: 30,
                  wt: MediaQuery.of(context).size.width * (0.15),
                  wet: MediaQuery.of(context).size.width * (0.8),
                  padding: EdgeInsets.all(8.0),
                  validator: (value) =>
                      value!.isEmpty ? 'Capitulo es requerido' : '',
                  controller: _ctr_cap,
                ),
                UtilsWidget.editTextRowTitle(
                  title: 'Fecha:',
                  ht: 30,
                  het: 30,
                  wt: MediaQuery.of(context).size.width * (0.15),
                  wet: MediaQuery.of(context).size.width * (0.8),
                  padding: EdgeInsets.all(8.0),
                  controller: _ctr_date,
                ),
                UtilsWidget.editTextRowTitle(
                  title: 'Dia:',
                  ht: 30,
                  het: 30,
                  wt: MediaQuery.of(context).size.width * (0.15),
                  wet: MediaQuery.of(context).size.width * (0.8),
                  padding: EdgeInsets.all(8.0),
                  controller: _ctr_day,
                ),
                UtilsWidget.buttonGeneric(
                    text: 'Guardar',
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    onClicks: () {
                      print('object');
                      String _im = _saveImageB64(_imagen);
                      VideoModel videoModel = VideoModel(
                        name: _ctr_name.text,
                        capitule: int.parse(_ctr_cap.text),
                        date: _ctr_date.text,
                        day: _ctr_day.text,
                        state: -1,
                        image: _im,
                      );
                      print(videoModel);
                      DB.insert(videoModel);

                      setState(() {
                        _ctr_name.text = '';
                        _ctr_cap.text = '';
                        _ctr_date.text = '';
                        _ctr_day.text = '';
                        _ctr_image.text = '';
                        _imagen = null;
                        Utils.toast('Guardado con exito...');
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
