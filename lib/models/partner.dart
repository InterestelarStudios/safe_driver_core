// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:safe_driver_core/models/product.dart';
import 'package:safe_driver_core/models/usuario.dart';

class Partner {

  String id;
  String name;
  String category;
  List partners;
  List<LiderancaDetails> partnersDetails;
  List adms;
  GeoPoint geoPoint;
  String address;
  List images;
  String? logo;
  String? description;
  List<ProductPartner> products;
  Timestamp created;

  Partner({
    required this.id,
    required this.name,
    required this.category,
    required this.partners,
    required this.partnersDetails,
    required this.adms,
    required this.geoPoint,
    required this.address,
    required this.images,
    this.logo,
    this.description,
    required this.products,
    required this.created,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'partners': partners,
      'partnersDetails': partnersDetails.map((x) => x.toMap()).toList(),
      'adms': adms,
      'geoPoint': geoPoint,
      'address': address,
      'images': images,
      'logo': logo,
      'description': description,
      'products': products.map((x) => x.toMap()).toList(),
      'created': created,
    };
  }

  factory Partner.fromMap(Map<String, dynamic> map) {
    return Partner(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      partners: List.from((map['partners'] as List)),
      partnersDetails: List<LiderancaDetails>.from((map['partnersDetails'] as List<int>).map<LiderancaDetails>((x) => LiderancaDetails.fromMap(x as Map<String,dynamic>),),),
      adms: List.from((map['adms'] as List)),
      geoPoint: map['geoPoint'] as GeoPoint,
      address: map['address'] as String,
      images: List.from((map['images'] as List)),
      logo: map['logo'] != null ? map['logo'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      products: List<ProductPartner>.from((map['products'] as List<int>).map<ProductPartner>((x) => ProductPartner.fromMap(x as Map<String,dynamic>),),),
      created: map['created'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Partner.fromJson(String source) => Partner.fromMap(json.decode(source) as Map<String, dynamic>);
}
