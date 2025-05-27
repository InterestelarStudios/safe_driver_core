// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_driver_core/models/usuario.dart';

class Equipe {

  String? id;
  String? name;
  String? image;
  LiderancaDetails? lideranca;
  Timestamp? created;
  List? adms;
  num? members;
  num? admsNum;
  String? code;
  
  Equipe({
    this.id,
    this.name,
    this.image,
    this.lideranca,
    this.created,
    this.adms,
    this.members,
    this.admsNum,
    this.code,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'lideranca': lideranca?.toMap(),
      'created': created,
      'adms': adms,
      'members': members,
      'admsNum': admsNum,
      'code': code,
    };
  }

  factory Equipe.fromMap(Map<String, dynamic> map) {
    return Equipe(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      lideranca: map['lideranca'] != null ? LiderancaDetails.fromMap(map['lideranca'] as Map<String,dynamic>) : null,
      created: map['created'] != null ? map['created'] as Timestamp : null,
      adms: map['adms'] != null ? map['adms'] as List : null,
      members: map['members'] != null ? map['members'] as num : null,
      admsNum: map['admsNum'] != null ? map['admsNum'] as num : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Equipe.fromJson(String source) => Equipe.fromMap(json.decode(source) as Map<String, dynamic>);
}
