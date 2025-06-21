import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_driver_core/models/danger_area.dart';

class GetMapsData {

  GetMapsData();

  Future<Set<Polygon>> getDangerAreas(String lideranca) async {
    Set<Polygon> polygons = {};
    final query = await FirebaseFirestore.instance.collection("dangerAreas")
    .where("lideranca.id", isEqualTo: lideranca)
    .withConverter(fromFirestore: (snapshot, options)=> DangerArea.fromMap(snapshot.data()!), toFirestore: (snapshot, options)=> {})
    .get();
    for(var data in query.docs){
      final dangerArea = data.data();
      polygons.add(
        Polygon(
          polygonId: PolygonId(dangerArea.id),
          points: dangerArea.points,
          strokeWidth: 1,
          strokeColor: Colors.redAccent[700]!,
          fillColor: Colors.redAccent[700]!.withAlpha(60),
        )
      );
    }
    return polygons;
  }

}