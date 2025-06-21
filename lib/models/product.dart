import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductPartner {

  String description;
  num normalPrice;
  num partnerPrice;
  
  ProductPartner({
    required this.description,
    required this.normalPrice,
    required this.partnerPrice,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'normalPrice': normalPrice,
      'partnerPrice': partnerPrice,
    };
  }

  factory ProductPartner.fromMap(Map<String, dynamic> map) {
    return ProductPartner(
      description: map['description'] as String,
      normalPrice: map['normalPrice'] as num,
      partnerPrice: map['partnerPrice'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPartner.fromJson(String source) => ProductPartner.fromMap(json.decode(source) as Map<String, dynamic>);
}
