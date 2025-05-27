// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Partner {

  String id;
  String name;
  String category;
  List partners;
  List adms;
  GeoPoint geoPoint;
  String address;
  List images;
  String? logo;
  String? description;
  Timestamp created;

  Partner({
    required this.id,
    required this.name,
    required this.category,
    required this.partners,
    required this.adms,
    required this.geoPoint,
    required this.address,
    required this.images,
    required this.created,
    this.logo,
    this.description,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'partners': partners,
      'adms': adms,
      'geoPoint': geoPoint,
      'address': address,
      'logo': logo,
      'images': images,
      'description': description,
    };
  }

  factory Partner.fromMap(Map<String, dynamic> map) {
    return Partner(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      partners: List.from((map['partners'] as List)),
      adms: List.from((map['adms'] as List)),
      geoPoint: map['geoPoint'] as GeoPoint,
      address: map['address'] as String,
      logo: map['logo'] != null ? map['logo'] as String : null,
      images: List.from((map['images'] as List)),
      description: map['description'] != null ? map['description'] as String : null,
      created: map['created'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Partner.fromJson(String source) => Partner.fromMap(json.decode(source) as Map<String, dynamic>);
}
