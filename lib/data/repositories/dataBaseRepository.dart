import 'dart:ffi';

import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository implements NasaRepository {
  DatabaseRepository._();

  static final DatabaseRepository _repository = DatabaseRepository._();

  factory DatabaseRepository() {
    return _repository;
  }

  Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), 'nasa_photo.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE photo(date TEXT PRIMARY KEY, url TEXT, title TEXT, media_type TEXT, explanation TEXT, book_mark_type INTEGER DEFAULT 0)");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        switch (oldVersion) {
          case 1:
            db.execute(
                "ALERT TABLE photo ADD COLUMN book_mark_type INTEGER DEFAULT 0");
            break;
        }
      },
      version: 2,
    );
  }

  @override
  Future<List<NasaPhoto>> loadPhotos(
      {String startDate = "", String endDate = ""}) async {
    print("load photos from database.....");
    final Database db = await database;
    final List<Map<String, dynamic>> queryResult =
        await db.query("photo", orderBy: "date DESC");
    return List.generate(
        queryResult.length, (index) => NasaPhoto.fromMap(queryResult[index]));
  }

  Future<List<NasaPhoto>> loadBookmarkPhotos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> queryResult = await db.query(
      "photo",
      orderBy: "date DESC",
      where: 'book_mark_type = ?',
      whereArgs: [1],
    );
    return List.generate(
        queryResult.length, (index) => NasaPhoto.fromMap(queryResult[index]));
  }

  @override
  void init() async {}

  Future<void> insertPhoto(List<NasaPhoto> photos) async {
    final Database db = await database;
    photos.forEach((element) {
      db.insert("photo", element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  @override
  Future<void> updatePhoto(NasaPhoto photo) async {
    final Database db = await database;
    await db.update('photo', photo.toMap(),
        where: 'date = ? AND title = ? AND url = ?',
        whereArgs: [photo.date, photo.title, photo.url]);
  }
}
