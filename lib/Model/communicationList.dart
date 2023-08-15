import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// communications  model
class Communicationlist {
  final String name;
  final String Status;
  bool value;

  Communicationlist({
    required this.name,
    required this.Status,
    required this.value,
  });
}
