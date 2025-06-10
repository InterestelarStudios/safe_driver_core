// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:safe_driver_core/models/lideranca.dart';
import 'package:safe_driver_core/models/usuario.dart';

class Statement {

  String id;
  String messege;
  LiderancaDetails lideranca;
  List destinations;
  List<EquipeDetails> destinationsDetails;
  UserDetails creator;
  Timestamp created;

  Statement({
    required this.id,
    required this.messege,
    required this.lideranca,
    required this.creator,
    required this.created,
    required this.destinations,
    required this.destinationsDetails,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'messege': messege,
      'lideranca': lideranca.toMap(),
      'creator': creator.toMap(),
      'created': created,
      'destinations': destinations,
      'destinationsDetails': destinationsDetails.map((x)=> x.toMap()).toList()
    };
  }

  factory Statement.fromMap(Map<String, dynamic> map) {
    return Statement(
      id: map['id'] as String,
      messege: map['messege'] as String,
      lideranca: LiderancaDetails.fromMap(map['lideranca'] as Map<String,dynamic>),
      creator: UserDetails.fromMap(map['creator'] as Map<String,dynamic>),
      created: map['created'] as Timestamp,
      destinations: map['destinations'] as List,
      destinationsDetails: map['destinationsDetails'].map<EquipeDetails>((e)=> EquipeDetails.fromMap(e)).toList()
    );
  }

  String toJson() => json.encode(toMap());

  factory Statement.fromJson(String source) => Statement.fromMap(json.decode(source) as Map<String, dynamic>);
}
