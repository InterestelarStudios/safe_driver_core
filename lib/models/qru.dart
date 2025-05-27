// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    );
  }

  String toJson() => json.encode(toMap());

  factory QRU.fromJson(String source) => QRU.fromMap(json.decode(source) as Map<String, dynamic>);
}
