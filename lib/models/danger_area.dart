// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_driver_core/safe_driver_core.dart';

class DangerArea {

  String id;
  LiderancaDetails lideranca;
  UserDetails creator;
  Timestamp created;
  List<LatLng> points;

  DangerArea({
    required this.id,
    required this.lideranca,
    required this.creator,
    required this.created,
    required this.points,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lideranca': lideranca.toMap(),
      'creator': creator.toMap(),
      'created': created,
      'points': points.map<GeoPoint>((x) => GeoPoint(x.latitude, x.longitude)).toList(),
    };
  }

  factory DangerArea.fromMap(Map<String, dynamic> map) {
    return DangerArea(
      id: map['id'] as String,
      lideranca: LiderancaDetails.fromMap(map['lideranca'] as Map<String,dynamic>),
      creator: UserDetails.fromMap(map['creator'] as Map<String,dynamic>),
      created: map['created'] as Timestamp,
      points: map['points'].map<LatLng>((e)=> LatLng(e.latitude, e.longitude)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DangerArea.fromJson(String source) => DangerArea.fromMap(json.decode(source) as Map<String, dynamic>);
}
