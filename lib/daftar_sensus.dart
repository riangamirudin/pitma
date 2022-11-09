import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/edit_form.dart';
import 'package:project/hive/helper.dart';
import 'package:project/models/data.dart';
import 'package:project/show_map.dart';

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
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image.file(
                            File(data!.foto!),
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowMap(
                                latLng: data.location!,
                              ),
                            ),
                          ),
                          child: Expanded(
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
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditFormPage(title: 'Edit data', indexHive: index))),
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.blue),
                                ),
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
