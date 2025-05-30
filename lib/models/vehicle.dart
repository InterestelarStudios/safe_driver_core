// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_driver_core/models/lideranca.dart';

class Vehicle {

  String id;
  String type;
  String brand;
  String model;
  String year;
  String color;
  String placa;
  Timestamp created;
  UserDetails owner;

  Vehicle({
    required this.id,
    required this.type,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.placa,
    required this.created,
    required this.owner,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'placa': placa,
      'created': created,
      'owner': owner.toMap(),
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'] as String,
      type: map['type'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as String,
      color: map['color'] as String,
      placa: map['placa'] as String,
      created: map['created'] as Timestamp,
      owner: UserDetails.fromMap(map['owner'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) => Vehicle.fromMap(json.decode(source) as Map<String, dynamic>);
}
