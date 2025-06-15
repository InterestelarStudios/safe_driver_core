// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:safe_driver_core/models/lideranca.dart';
import 'package:safe_driver_core/models/usuario.dart';

/*
Levels:
1: Perigo (Risco de vida),
2: Urgência (Risco de danos pessoais e materiais),
3: Leve (Sem riscos)
*/

class QRU {

  String? id;
  UserDetails? from;
  String? status;
  int? level;
  List? involveds;
  List<UserDetails>? involvedsDetails;
  EquipeDetails? equipe;
  LiderancaDetails? lideranca;
  Timestamp? created;
  Timestamp? closed;
  String? description;
  GeoPoint? position;
  String? address;
  List<FileType>? medias;

  QRU({
    this.id,
    this.from,
    this.status,
    this.level,
    this.involveds,
    this.involvedsDetails,
    this.equipe,
    this.lideranca,
    this.created,
    this.closed,
    this.description,
    this.position,
    this.medias,
    this.address,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from': from!.toMap(),
      'status': status,
      'level': level,
      'involveds': involveds,
      'involvedsDetails': involvedsDetails!.map((x) => x.toMap()).toList(),
      'equipe': equipe!.toMap(),
      'lideranca': lideranca!.toMap(),
      'created': created,
      'closed': closed,
      'description': description,
      'position': position,
      'address': address,
      'medias': medias!.map((x)=> x.toMap()).toList(),
    };
  }

  factory QRU.fromMap(Map<String, dynamic> map) {
    return QRU(
      id: map['id'] != null ? map['id'] as String : null,
      from: map['from'] != null ? UserDetails.fromMap(map['from'] as Map<String,dynamic>) : null,
      status: map['status'] != null ? map['status'] as String : null,
      level: map['level'] != null ? map['level'] as int : null,
      involveds: map['involveds'] != null ? map['involveds'] as List : null,
      involvedsDetails: map['involvedsDetails'].isNotEmpty ? map['involvedsDetails'].map((e)=> UserDetails.fromMap(e)).toList() : [],
      equipe: map['equipe'] != null ? EquipeDetails.fromMap(map['equipe']) : null,
      lideranca: map['lideranca'] != null ? LiderancaDetails.fromMap(map['lideranca']) : null,
      created: map['created'] != null ? map['created'] as Timestamp : null,
      closed: map['closed'] != null ? map['closed'] as Timestamp : null,
      description: map['description'] != null ? map['description'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      position: map['position'] != null ? map['position'] as GeoPoint : null,
      medias: map['medias'] != null ?  map['medias'].map<FileType>((e)=> FileType.fromMap(e)).toList() as List<FileType>: null,
    );
  }

  String levelTranslated(){
    switch (level) {
      case 0:
        return "Leve";
      case 1:
        return "Urgência";
      case 2:
        return "Risco de Vida";
      default:
        return "";
    }
  }

  Color levelColor(){
    switch (level) {
      case 0:
        return Colors.yellowAccent[700]!;
      case 1:
        return Colors.orangeAccent[700]!;
      case 2:
        return Colors.redAccent[700]!;
      default:
        return Colors.grey;
    }
  }

  String toJson() => json.encode(toMap());

  factory QRU.fromJson(String source) => QRU.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FileType {
  String url;
  String type;

  FileType({
    required this.url,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'type': type,
    };
  }

  factory FileType.fromMap(Map<String, dynamic> map) {
    return FileType(
      url: map['url'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileType.fromJson(String source) => FileType.fromMap(json.decode(source) as Map<String, dynamic>);
}

class InQruDetails {
  /*
  roles":
    -owner: Criardor da QRU
    -envolved: Disposto a Ajudar na QRU
  */
  String qruId;
  UserDetails from;
  String role;
  String description;
  
  InQruDetails({
    required this.qruId,
    required this.from,
    required this.role,
    required this.description,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qruId': qruId,
      'from': from.toMap(),
      'role': role,
      'description': description,
    };
  }

  factory InQruDetails.fromMap(Map<String, dynamic> map) {
    return InQruDetails(
      qruId: map['qruId'] as String,
      from: UserDetails.fromMap(map['from'] as Map<String,dynamic>),
      role: map['role'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InQruDetails.fromJson(String source) => InQruDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
