import 'package:alistvideos/model/VideoModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static final String TABLE_VIDEO = 'videos';

  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'alistdb.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $TABLE_VIDEO (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, capitule INTEGER, day TEXT, date TEXT, state INTEGER, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(VideoModel videoModel) async {
    Database database = await _openDB();

    await database.insert(
      TABLE_VIDEO,
      videoModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(VideoModel videoModel) async {
    Database database = await _openDB();
    print('${videoModel.id} Deleted...');
    await database
        .delete(TABLE_VIDEO, where: "id = ?", whereArgs: [videoModel.id]);
  }

  static Future<void> update(VideoModel videoModel) async {
    Database database = await _openDB();

    await database.update(TABLE_VIDEO, videoModel.toMap(),
        where: "id = ?", whereArgs: [videoModel.id]);
  }

  static Future<List<VideoModel>> videos() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> videosMap =
        await database.query(TABLE_VIDEO);

    return List.generate(
        videosMap.length,
        (i) => VideoModel(
              id: videosMap[i]['id'],
              name: videosMap[i]['name'],
              capitule: videosMap[i]['capitule'],
              date: videosMap[i]['date'],
              day: videosMap[i]['day'],
              state: videosMap[i]['state'],
              image: videosMap[i]['image'],
            ));
  }

  //Con sentencias
  static Future<void> insert2(VideoModel vm) async {
    Database database = await _openDB();
    // ignore: unused_local_variable
    var resultado = await database.rawInsert(
        "INSERT INTO $TABLE_VIDEO (id , name, capitule, day, date, state, image)"
        " VALUES (${vm.id}, ${vm.name}, ${vm.capitule}, ${vm.day}, ${vm.date}, ${vm.state}, ${vm.image})");
  }
}
