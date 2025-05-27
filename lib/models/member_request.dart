// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_driver_core/models/lideranca.dart';
import 'package:safe_driver_core/models/usuario.dart';

class MemberRequest {

  String id;
  String status;
  UserDetails userDetails;
  LiderancaDetails lideranca;
  EquipeDetails equipe;
  Timestamp date;

  MemberRequest({
    required this.id,
    required this.status,
    required this.userDetails,
    required this.lideranca,
    required this.equipe,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'userDetails': userDetails.toMap(),
      'lideranca': lideranca.toMap(),
      'equipe': equipe.toMap(),
      'date': date,
    };
  }

  factory MemberRequest.fromMap(Map<String, dynamic> map) {
    return MemberRequest(
      id: map['id'] as String,
      status: map['status'] as String,
      userDetails: UserDetails.fromMap(map['userDetails'] as Map<String,dynamic>),
      lideranca: LiderancaDetails.fromMap(map['lideranca'] as Map<String,dynamic>),
      equipe: EquipeDetails.fromMap(map['equipe'] as Map<String,dynamic>),
      date: map['date'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberRequest.fromJson(String source) => MemberRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
