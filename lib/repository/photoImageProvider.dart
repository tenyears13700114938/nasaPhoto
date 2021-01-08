
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PhotoImageProvider {
  final String url;
  final String date;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final name = getFileName(date, url);
    if(name.isEmpty){
      return Future.value(null);
    }
    return File('$path/$name');
  }

  PhotoImageProvider(this.url, this.date);

  Future<ImageProvider> getProvider() async {
    final file = await _localFile;
    if(file != null){
      final exists = await file.exists();
      if(exists){
        return FileImage(file);
      } else {
        saveImage(url, file);
        return NetworkImage(url);
      }
    }
    return NetworkImage(url);
  }

  void saveImage(String url, File file) async {
    final response = await http.get(url);
    if(response.statusCode == 200){
      file.writeAsBytes(response.bodyBytes);
    }
  }

  String getFileName(String date, String url){
    int startIndex = url.lastIndexOf("/");
    if(startIndex != -1) {
      String jpgName = url.substring(startIndex + 1);
      return '$date-$jpgName';
    }
    return '';
  }
}