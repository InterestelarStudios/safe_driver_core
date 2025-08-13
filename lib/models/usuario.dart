// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:safe_driver_core/models/lideranca.dart';
import 'package:safe_driver_core/models/qru.dart';
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
  InQruDetails? inQru;
  LegalData? legalData;
  MedicalData? medicalData;
  Plan? plan;
  String? serviceType; //passenger: Transporte de Passageiros. deliveryPackage: Entrega de Pacotes. deliveryFood: Entrega de Alimentos.
  String? status;
  bool? showAddress;
  List<PhoneData>? emergencyContacts;
  List<PhoneData>? trackers;

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
    this.inQru,
    this.legalData,
    this.medicalData,
    this.plan,
    this.serviceType,
    this.status,
    this.showAddress,
    this.emergencyContacts,
    this.trackers,
  });

  UserDetails toDetails({String? function}){
    return UserDetails(
      id: id!,
      username: username!,
      function: function ?? equipe!.name!,
      email: email!,
      vtr: vtr ?? num.parse("0"),
      image: image,
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
      'inQru': inQru?.toMap(),
      'legalData': legalData?.toMap(),
      'medicalData': medicalData?.toMap(),
      'plan' : plan?.toMap(),
      'serviceType': serviceType,
      'status': status,
      'showAddress': showAddress,
      'emergencyContacts': emergencyContacts!.map((e)=> e.toMap()).toList(),
      'trackers': trackers!.map((e)=> e.toMap()).toList(),
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
      inQru: map['inQru'] != null ? InQruDetails.fromMap(map['inQru']) : null,
      legalData: map['legalData'] != null ? LegalData.fromMap(map['legalData']) : null,
      medicalData: map['medicalData'] != null ? MedicalData.fromMap(map['medicalData']) : null,
      plan: map['plan'] != null ? Plan.fromMap(map['plan']) : null,
      serviceType: map['serviceType'] != null ? map['serviceType'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      showAddress: map['showAddress'] != null ? map['showAddress'] as bool : null,
      emergencyContacts: map['emergencyContacts'] != null ? map['emergencyContacts'].map<PhoneData>((e)=> PhoneData.fromMap(e)).toList() : [],
      trackers: map['trackers'] != null ? map['trackers'].map<PhoneData>((e)=> PhoneData.fromMap(e)).toList() : [],
    );
  }

  bool isProfessional(){
    if(plan == null){
      return false;
    } else {
      if(plan!.name == "Gratuito"){
        return false;
      } else {
        if(Timestamp.now().toDate().isBefore(plan!.dueDate.toDate().add(const Duration(days: 3)))){
          return true;
        } else {
          return false;
        }
      }
    }
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


class LegalData {

  String name;
  String? rg;
  String cpf;
  String cnh;
  String phone;
  BirthDate birth;
  Address address;

  LegalData({
    required this.name,
    this.rg,
    required this.cpf,
    required this.cnh,
    required this.phone,
    required this.birth,
    required this.address,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'rg': rg,
      'cpf': cpf,
      'cnh': cnh,
      'phone': phone,
      'birth': birth.toMap(),
      'address': address.toMap(),
    };
  }

  factory LegalData.fromMap(Map<String, dynamic> map) {
    return LegalData(
      name: map['name'] as String,
      rg: map['rg'] != null ? map['rg'] as String : null,
      cpf: map['cpf'] as String,
      cnh: map['cnh'] as String,
      phone: map['phone'] as String,
      birth: BirthDate.fromMap(map['birth'] as Map<String,dynamic>),
      address: Address.fromMap(map['address'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LegalData.fromJson(String source) => LegalData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Address {

  String street;
  String number;
  String district;
  String cep;
  String city;
  String uf;
  String? complement;

  Address({
    required this.street,
    required this.number,
    required this.district,
    required this.cep,
    required this.city,
    required this.uf,
    this.complement,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street': street,
      'number': number,
      'district': district,
      'cep': cep,
      'city': city,
      'uf': uf,
      'complement': complement,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] as String,
      number: map['number'] as String,
      district: map['district'] as String,
      cep: map['cep'] as String,
      city: map['city'] as String,
      uf: map['uf'] as String,
      complement: map['complement'] != null ? map['complement'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BirthDate {

  String day;
  String month;
  String year;

  BirthDate({
    required this.day,
    required this.month,
    required this.year,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory BirthDate.fromMap(Map<String, dynamic> map) {
    return BirthDate(
      day: map['day'] as String,
      month: map['month'] as String,
      year: map['year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BirthDate.fromJson(String source) => BirthDate.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MedicalData {

  String bloodType;
  List allergy;

  MedicalData({
    required this.bloodType,
    required this.allergy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bloodType': bloodType,
      'allergy': allergy,
    };
  }

  factory MedicalData.fromMap(Map<String, dynamic> map) {
    return MedicalData(
      bloodType: map['bloodType'] as String,
      allergy: List.from((map['allergy'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalData.fromJson(String source) => MedicalData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Plan {

  String name;
  Timestamp dueDate;
  num price;
  
  Plan({
    required this.name,
    required this.dueDate,
    required this.price,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dueDate': dueDate,
      'price': price,
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      name: map['name'] as String,
      dueDate: map['dueDate'] as Timestamp,
      price: map['price'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) => Plan.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<Plan> planos = [
  Plan(name: "Gratuito", dueDate: Timestamp.now(), price: 0),
  Plan(name: "Profissional", dueDate: Timestamp.now(), price: 19.90),
];

class PhoneData {

  String number;
  String name;
  
  PhoneData({
    required this.number,
    required this.name,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'name': name,
    };
  }

  factory PhoneData.fromMap(Map<String, dynamic> map) {
    return PhoneData(
      number: map['number'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneData.fromJson(String source) => PhoneData.fromMap(json.decode(source) as Map<String, dynamic>);
}
