// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AgoraTokenService {
  AgoraTokenService();

  /// Recupera o token do Agora gerado pela Cloud Function.
  Future<AgoraToken?> fetchAgoraToken(String channelName, String role, String userId, String type, bool isPublisher) async {
    final uri = Uri.parse(
      "https://generateagoratoken-dutnw2r2sq-uc.a.run.app?channelName=$channelName&role=$role&userId=$userId&type=$type&isPublisher=$isPublisher",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return AgoraToken(
        token: data['token'],
        uid: data['uid'],
        expiration: Timestamp.fromDate(Timestamp.now().toDate().add(const Duration(hours: 24))),
        channelName: channelName
      );
    } else {
      print("Erro ao obter token: ${response.body}");
      return null;
    }
  }
}

class AgoraToken {
  String token;
  int uid;
  Timestamp expiration;
  String channelName;
  AgoraToken({
    required this.token,
    required this.uid,
    required this.expiration,
    required this.channelName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'uid': uid,
      'expiration': expiration,
      'channelName': channelName,
    };
  }

  factory AgoraToken.fromMap(Map<String, dynamic> map) {
    return AgoraToken(
      token: map['token'] as String,
      uid: map['uid'] as int,
      expiration: map['expiration'] as Timestamp,
      channelName: map['channelName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgoraToken.fromJson(String source) => AgoraToken.fromMap(json.decode(source) as Map<String, dynamic>);
}
