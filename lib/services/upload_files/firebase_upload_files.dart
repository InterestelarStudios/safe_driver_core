import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadFilesFirestore {

  UploadFilesFirestore();

  Future<String?> uploadSingleFile({
    required File file,
    required String folder,
    String? fileName,
  }) async {
    try {
      fileName ??= file.path.split('/').last;
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('$folder/$fileName');

      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('========================================================================================');
      debugPrint('Erro ao fazer upload do arquivo: $e');
      debugPrint('========================================================================================');
      return null;
    }
  }

}