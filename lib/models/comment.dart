// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:safe_driver_core/models/lideranca.dart';

class SocialComment {

  String id;
  String postId;
  UserDetails user;
  List likes;
  String content;
  Timestamp date;

  SocialComment({
    required this.id,
    required this.postId,
    required this.user,
    required this.likes,
    required this.content,
    required this.date,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'postId': postId,
      'user': user.toMap(),
      'likes': likes,
      'content': content,
      'date': date,
    };
  }

  factory SocialComment.fromMap(Map<String, dynamic> map) {
    return SocialComment(
      id: map['id'] as String,
      postId: map['postId'] as String,
      user: UserDetails.fromMap(map['user'] as Map<String,dynamic>),
      likes: map['likes'] as List,
      content: map['content'] as String,
      date: map['date'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialComment.fromJson(String source) => SocialComment.fromMap(json.decode(source) as Map<String, dynamic>);
}
