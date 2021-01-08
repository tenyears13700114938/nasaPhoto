
import 'package:flutter_nasa_photo/model/nasaPhoto.dart';
import 'package:flutter_nasa_photo/repository/nasaRepository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseRepository implements NasaRepository {
  Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), 'nasa_photo.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE photo(date TEXT PRIMARY KEY, url TEXT, title TEXT, media_type TEXT, explanation TEXT)");
        },
      version: 1,
    );
  }
  
  @override
  Future<List<NasaPhoto>> loadPhotos({String startDate = "", String endDate = ""}) async{
    print("load photos from database.....");
    final Database db = await database;
    final List<Map<String, dynamic>>  queryResult = await db.query("photo",
      orderBy: "date DESC"
    );
    return List.generate(queryResult.length, (index) => NasaPhoto.fromMap(queryResult[index]));
  }

  @override
  void init() async {
  }

  Future<void> insertPhoto(List<NasaPhoto> photos) async {
    final Database db  = await database;
    photos.forEach((element) {
      db.insert(
          "photo",
          element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace
      );
    });
  }
}