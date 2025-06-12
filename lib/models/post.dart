// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:safe_driver_core/safe_driver_core.dart';

class SocialPost {

  String id;
  UserDetails creator;
  LiderancaDetails lideranca;
  String content;
  List<FileType> files;
  Timestamp date;
  bool edited;
  List likes;
  int comments;

  SocialPost({
    required this.id,
    required this.creator,
    required this.lideranca,
    required this.content,
    required this.files,
    required this.date,
    required this.edited,
    required this.likes,
    required this.comments,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creator': creator.toMap(),
      'lideranca': lideranca.toMap(),
      'content': content,
      'files': files.map((x) => x.toMap()).toList(),
      'date': date,
      'edited': edited,
      'likes': likes,
      'comments': comments,
    };
  }

  factory SocialPost.fromMap(Map<String, dynamic> map) {
    return SocialPost(
      id: map['id'] as String,
      creator: UserDetails.fromMap(map['creator'] as Map<String,dynamic>),
      lideranca: LiderancaDetails.fromMap(map['lideranca'] as Map<String,dynamic>),
      content: map['content'] as String,
      files: List<FileType>.from((map['files'] as List<int>).map<FileType>((x) => FileType.fromMap(x as Map<String,dynamic>),),),
      date: map['date'] as Timestamp,
      edited: map['edited'] as bool,
      likes: map['likes'] as List,
      comments: map['comments'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialPost.fromJson(String source) => SocialPost.fromMap(json.decode(source) as Map<String, dynamic>);
}
