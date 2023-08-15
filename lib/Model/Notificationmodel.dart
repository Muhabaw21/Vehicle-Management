
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';




@HiveType(typeId: 0)
class DataModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  // Define other fields as needed

  DataModel({required this.id, required this.name});
}