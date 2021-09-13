import 'dart:convert';
import 'dart:typed_data';

import 'package:alistvideos/model/VideoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

// ignore: non_constant_identifier_names
Widget ItemVideo({
  required BuildContext context,
  required List<VideoModel> list,
  required int index,
  Function()? onItemTap,
  bool enabledSwipe = false,
  Function(CompletionHandler handler)? onFinish,
  Function(CompletionHandler handler)? onEdit,
  Function(CompletionHandler handler)? onUpdate,
  Function(CompletionHandler handler)? onDelete,
}) =>
    enabledSwipe
        ? Container(
            margin: EdgeInsets.only(top: 5),
            child: SwipeActionCell(
              key: ObjectKey(list[index]),

              ///this key is necessary
              leadingActions: <SwipeAction>[
                SwipeAction(
                    title: "Editar",
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onTap: onEdit ?? (_) {},
                    color: Colors.blue),
                SwipeAction(
                    title: "Cap +1",
                    icon: Icon(
                      Icons.add_task_sharp,
                      color: Colors.white,
                    ),
                    onTap: onUpdate ?? (_) {},
                    color: Colors.green),
              ],
              trailingActions: [
                SwipeAction(
                    title: "Finalizar",
                    icon: Icon(
                      Icons.av_timer_sharp,
                      color: Colors.white,
                    ),
                    onTap: onFinish ?? (_) {},
                    color: Colors.black),
                SwipeAction(
                    title: "Borrar",
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                    onTap: onDelete ?? (_) {},
                    color: Colors.red),
              ],
              child: Container(
                decoration: BoxDecoration(
                  color: list[index].state != 0
                      ? Color(0xFFFFFFFF)
                      : Colors.green[100],
                ),
                child: ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: list[index].image != null
                              ? Image.memory(
                                  imageFromBase64String(list[index].image),
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.fill,
                                ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                '${list[index].name}'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Text(
                              'Capitulo: ${list[index].capitule}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              'Día: ${list[index].day}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              'Fecha: ${list[index].date}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  trailing: list[index].state == 0
                      ? Container(
                          width: 20,
                          alignment: Alignment.center,
                          child: Icon(Icons.check_circle_outlined,
                              color: Colors.green),
                        )
                      : Container(
                          width: 20,
                          alignment: Alignment.center,
                          child: Text('${list[index].id}')),
                  onTap: onItemTap,
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: list[index].state != 0
                  ? Color(0xFFFFFFFF)
                  : Colors.green[100],
            ),
            child: ListTile(
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            '${list[index].name}'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Text(
                          'Capitulo: ${list[index].capitule}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Día: ${list[index].day}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Fecha: ${list[index].date}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              trailing: list[index].state == 0
                  ? Container(
                      width: 20,
                      alignment: Alignment.center,
                      child: Icon(Icons.check_circle_outlined,
                          color: Colors.green),
                    )
                  : Container(
                      width: 20,
                      alignment: Alignment.center,
                      child: Text('${list[index].id}')),
              onTap: onItemTap,
            ),
          );

Uint8List imageFromBase64String(String? base64String) {
  return base64Decode(base64String!);
}
