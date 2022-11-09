import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/models/data.dart';

class DaftarSensus extends StatelessWidget {
  const DaftarSensus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box<DataModel>('sensus').listenable(),
        builder: (BuildContext context, Box<DataModel> box, Widget? child) {
          return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                DataModel? data = box.getAt(index);
                return Text(data!.kk.toString());
              });
        },
      ),
    );
  }
}
