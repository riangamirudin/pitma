import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/models/data.dart';

class HiveHelper {
  Box<DataModel> box = Hive.box<DataModel>('sensus');

  Future<bool> insert(DataModel data) async {
    box.add(data);
    return true;
  }

  Future<bool> update(int index, DataModel value) async {
    box.putAt(index, value);
    return true;
  }

  Future<bool> delete(int index) async {
    box.deleteAt(index);
    return true;
  }

  Future<List<DataModel>> getData() async {
    List<DataModel> data = [];
    for (var item in box.values) {
      data.add(item);
    }
    return data;
  }

  Future<DataModel?> getDetilData(int index) async {
    return box.getAt(index);
  }
}
