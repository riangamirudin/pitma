import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/hive/helper.dart';
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

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Image.file(
                              File(data!.foto!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.nama.toString(),
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                data.kk.toString() + ' | ' + data.jumlahKeluarga.toString() + ' jumlah keluarga',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                data.alamat.toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                data.location.toString(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Edit',
                                style: TextStyle(color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  HiveHelper().delete(index);
                                },
                                child: const Text(
                                  'Hapus',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
