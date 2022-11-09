import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class DataModel {
  @HiveField(0)
  final String? kk;
  @HiveField(1)
  late final String? nama;
  @HiveField(2)
  final int? jumlahKeluarga;
  @HiveField(3)
  final String? alamat;
  @HiveField(4)
  final String? location;
  @HiveField(5)
  final String? foto;

  DataModel({this.location, this.foto, this.kk, this.nama, this.jumlahKeluarga, this.alamat});
}
