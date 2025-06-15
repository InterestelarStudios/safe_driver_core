// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Lideranca {

  String? id;
  String? name;
  String? image;
  String? creator;
  String? state;
  String? businessName;
  String? cnpj;
  List<UserDetails>? admsDetails;
  List? adms;
  int? members;
  int? teams;
  Timestamp? created;
  String? code;
  
  Lideranca({
    this.id,
    this.name,
    this.image,
    this.creator,
    this.state,
    this.businessName,
    this.cnpj,
    this.admsDetails,
    this.adms,
    this.members,
    this.teams,
    this.created,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'creator': creator,
      'state': state,
      'businessName': businessName,
      'cnpj': cnpj,
      'adms': adms,
      'admsDetails': admsDetails!.map((x) => x.toMap()).toList(),
      'members': members,
      'teams': teams,
      'created': created,
      'code': code,
    };
  }

  factory Lideranca.fromMap(Map<String, dynamic> map) {
    return Lideranca(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      creator: map['creator'] != null ? map['creator'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      businessName: map['businessName'] != null ? map['businessName'] as String : null,
      cnpj: map['cnpj'] != null ? map['cnpj'] as String : null,
      adms: map['adms'] != null ? map['adms'] as List : null,
      admsDetails: map['admsDetails'] != null ? map['admsDetails'].map<UserDetails>((e)=> UserDetails.fromMap(e)).toList() as List<UserDetails> : null,
      members: map['members'] != null ? map['members'] as int : null,
      teams: map['teams'] != null ? map['teams'] as int : null,
      created: map['created'] != null ? map['created'] as Timestamp : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  bool isAdm(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return adms!.contains(uid);
  }

  String toJson() => json.encode(toMap());

  factory Lideranca.fromJson(String source) => Lideranca.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserDetails {

  String id;
  String username;
  String email;
  String? image;
  String function;
  num vtr;
  String? notificationToken;

  UserDetails({
    required this.id,
    required this.username,
    required this.function,
    required this.email,
    this.image,
    required this.vtr,
    this.notificationToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'function': function,
      'email': email,
      'image': image,
      'vtr': vtr,
      'notificationToken' : notificationToken,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id'] as String,
      function: map['function'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      vtr: map['vtr'] as int,
      notificationToken: map['notificationToken'] != null ? map['notificationToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) => UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
