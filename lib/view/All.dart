import 'package:alistvideos/common/Utils.dart';
import 'package:alistvideos/data/db.dart';
import 'package:alistvideos/items/ItemVideo.dart';
import 'package:alistvideos/model/VideoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class AllPage extends StatefulWidget {
  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  List<VideoModel>? list = [];

  final List<VideoModel> listx = [
    VideoModel(
        name: 'titulo del video 1 x',
        capitule: 1,
        id: 1,
        state: 1,
        day: 'Lunes',
        date: '12-12-2021 12:00 pm'),
    VideoModel(
        name:
            'titulo del video 2 es demasiado largo como, sabe si tiene doble linea',
        capitule: 5,
        id: 2,
        state: 1,
        day: 'Miercoles',
        date: '12-12-2021 12:00 pm'),
    VideoModel(
        name: 'titulo del video 3 es demasiado largo como',
        capitule: 4,
        id: 3,
        state: 1,
        day: 'Sabado',
        date: '12-12-2021 12:00 pm'),
    VideoModel(
        name:
            'titulo del video 4 es demasiado largo como, sabe si tiene doble linea',
        capitule: 1,
        id: 4,
        state: 1,
        day: 'Lunes',
        date: '12-12-2021 12:00 pm'),
  ];

  _dataDB() async {
    list = await DB.videos();
    setState(() {});
  }

  @override
  void initState() {
    _dataDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'all',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.82,
          child: FutureBuilder<List<VideoModel>>(
              future: DB.videos(), //terminar
              builder: (context, snapshot) {
                var _list = snapshot.hasData ? snapshot.data : list!;
                if (_list!.isEmpty) {
                  return Center(
                    child: Text(
                      'No Hay Videos guardados...',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await DB.videos();
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (_, i) {
                      return ItemVideo(
                        context: context,
                        list: _list,
                        index: i,
                        enabledSwipe: true,
                        //onItemTap: () => Utils.toast('selecciono el item #$i'),
                        onFinish: (CompletionHandler handler) async {
                          _list[i].setState = 0;
                          Utils.toast('Item #$i Finalizado...');
                          DB.update(_list[i]);
                          setState(() {});
                        },
                        onEdit: (CompletionHandler handler) async {
                          Utils.toast('EDITAR');
                        },
                        onUpdate: (CompletionHandler handler) async {
                          if (_list[i].state != 0) {
                            int _cap = (_list[i].capitule)! + 1;
                            _list[i].setCap = _cap;

                            //Utils.toast('Item #$i Actualizado cap: $_cap');
                            setState(() {
                              DB.update(_list[i]);
                            });
                          } else {
                            Utils.toastError(
                                'El Item #$i, no se puede actualizar');
                          }
                        },
                        onDelete: (CompletionHandler handler) async {
                          Utils.dialogMessage(
                              context: context,
                              height: 80,
                              title: 'Borrar',
                              message: 'Desea borrar ${_list[i].name}',
                              onclick: () {
                                try {
                                  DB.delete(_list[i]);
                                } catch (_) {}

                                _list.removeAt(i);
                                Utils.toast('Item Borrado');

                                setState(() {});
                              });
                        },
                      );
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
