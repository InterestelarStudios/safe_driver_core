// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_driver_core/models/lideranca.dart';
import 'package:safe_driver_core/models/vehicle.dart';
import 'package:safe_driver_core/services/agora_token_gen.dart';

class Usuario {

  String? id;
  String? username;
  String? email;
  EquipeDetails? equipe;
  LiderancaDetails? lideranca;
  String? image;
  Timestamp? created;
  num? vtr;
  String? streamToken;
  bool? working;
  AgoraToken? inCall;
  AgoraToken? inStream;
  GeoPoint? position;
  Timestamp? lastPosition;
  Vehicle? vehicle;

  Usuario({
    this.id,
    this.username,
    this.email,
    this.equipe,
    this.lideranca,
    this.image,
    this.created,
    this.vtr,
    this.streamToken,
    this.working,
    this.inCall,
    this.inStream,
    this.position,
    this.lastPosition,
    this.vehicle,
  });

  UserDetails toDetails({String? function}){
    return UserDetails(
      id: id!,
      username: username!,
      function: function ?? "",
      email: email!,
      vtr: vtr!,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'equipe': equipe?.toMap(),
      'lideranca': lideranca?.toMap(),
      'image': image,
      'created': created,
      'vtr': vtr,
      'streamToken': streamToken,
      'working': working,
      'inCall' : inCall?.toMap(),
      'inStream' : inStream?.toMap(),
      'position': position,
      'lastPosition': lastPosition,
      'vehicle': vehicle,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      equipe: map['equipe'] != null ? EquipeDetails.fromMap(map['equipe']) : null,
      lideranca: map['lideranca'] != null ? LiderancaDetails.fromMap(map['lideranca']) : null,
      image: map['image'] != null ? map['image'] as String : null,
      created: map['created'] != null ? map['created'] as Timestamp : null,
      vtr: map['vtr'] != null ? map['vtr'] as num : null,
      streamToken: map['streamToken'] != null ? map['streamToken'] as String : null,
      working: map['working'] != null ? map['working'] as bool : null,
      inCall: map['inCall'] != null ? AgoraToken.fromMap(map['inCall']) : null,
      inStream: map['inStream'] != null ? AgoraToken.fromMap(map['inStream']) : null,
      position: map['position'] != null ? map['position'] as GeoPoint : null,
      vehicle: map['vehicle'] != null ? Vehicle.fromMap(map['vehicle']) : null,
      lastPosition: map['lastPosition'] != null ? map['lastPosition'] as Timestamp : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LiderancaDetails {

  String? id;
  String? name;
  String? image;
  String? state;

  LiderancaDetails({
    this.id,
    this.name,
    this.image,
    this.state,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'state': state,
    };
  }

  factory LiderancaDetails.fromMap(Map<String, dynamic> map) {
    return LiderancaDetails(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LiderancaDetails.fromJson(String source) => LiderancaDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}

class EquipeDetails {

  String? id;
  String? name;
  String? image;
  String? lideranca;

  EquipeDetails({
    this.id,
    this.name,
    this.image,
    this.lideranca,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'lideranca': lideranca,
    };
  }

  factory EquipeDetails.fromMap(Map<String, dynamic> map) {
    return EquipeDetails(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      lideranca: map['lideranca'] != null ? map['lideranca'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipeDetails.fromJson(String source) => EquipeDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
