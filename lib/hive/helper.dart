import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/models/data.dart';

class HiveHelper {
  Box<DataModel> box = Hive.box<DataModel>('sensus');

  Future<bool> insert(DataModel data) async {
    box.add(data);
    return true;
  }

  Future<bool> update() async {
    return false;
  }

  Future<bool> delete() async {
    return false;
  }

  Future<List<DataModel>> getData() async {
    List<DataModel> data = [];
    for (var item in box.values) {
      data.add(item);
    }
    return data;
  }
}
