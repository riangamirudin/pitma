import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/helper.dart';
import 'package:project/hive/helper.dart';
import 'package:project/daftar_sensus.dart';
import 'package:project/models/data.dart';

class EditFormPage extends StatefulWidget {
  final int indexHive;
  const EditFormPage({Key? key, required this.title, required this.indexHive}) : super(key: key);

  final String title;

  @override
  State<EditFormPage> createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  final TextEditingController kkController = TextEditingController();
  final TextEditingController namaKkController = TextEditingController();
  final TextEditingController jmlKeluargaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  final formKey = GlobalKey<FormState>();

  bool loadingGetLocation = false;
  String? currentLocation;
  String? pathFoto;

  @override
  void initState() {
    HiveHelper().getDetilData(widget.indexHive).then((DataModel? value) {
      kkController.text = value!.kk!.toString();
      namaKkController.text = value.nama.toString();
      jmlKeluargaController.text = value.jumlahKeluarga.toString();
      alamatController.text = value.alamat.toString();
      currentLocation = value.location.toString();
      pathFoto = value.foto.toString();
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    kkController.dispose();
    namaKkController.dispose();
    jmlKeluargaController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: kkController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'No KK',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: namaKkController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Nama KK',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: jmlKeluargaController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Jumlah keluarga',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: alamatController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Alamat',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Icon(Icons.location_on),
                    Text(
                      'Lokasi Sekarang',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    currentLocation!,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                    onPressed: () async {
                      final file = await Helper().pickImageFromGallery();
                      if (file != null) {
                        setState(() {
                          pathFoto = file.path;
                        });
                      }
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.folder),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Pilih foto',
                        ),
                      ],
                    ),
                  ),
                ),
                if (pathFoto != null && pathFoto!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text(
                      pathFoto!.split('/').last,
                      textAlign: TextAlign.start,
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (currentLocation == null || pathFoto == null) {
                          String text = 'Masih ada data yang kosong';
                          if (currentLocation == null) {
                            text = 'Pilih lokasi dulu';
                          } else if (pathFoto == null) {
                            text = 'Pilih foto dulu';
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(text),
                              backgroundColor: Colors.red.shade300,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          final result = await HiveHelper().update(
                            widget.indexHive,
                            DataModel(
                              kk: kkController.text,
                              nama: namaKkController.text,
                              jumlahKeluarga: int.parse(jmlKeluargaController.text),
                              alamat: alamatController.text,
                              foto: pathFoto,
                              location: currentLocation,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result ? 'Berhasil simpan' : 'Gagal simpan'),
                              backgroundColor: result ? Colors.green.shade300 : Colors.red.shade300,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
