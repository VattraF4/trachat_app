//package
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String USER_COLLECTION = "Users";

class CloudStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CloudStorageService();

  Future<String?> saveUserImageToStorage(String uid, PlatformFile file) async {
    try {
      Reference _ref = _storage.ref().child(
        'images/users/$uid/profile.${file.extension}',
      );
      UploadTask _task = _ref.putFile(File(file.path!));
      return await _task.then((result) => result.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
  }

  Future<String?> SaveChatImageToStorage(
    String chatID,
    String userID,
    PlatformFile file,
  ) async {
    try {
      String path =
          'images/chats/$chatID/${userID}_${Timestamp.now().millisecondsSinceEpoch}.${file.extension}';
      Reference _ref = _storage.ref().child(path);
      UploadTask _task = _ref.putFile(File(path));
      return await _task.then((result) => result.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
  }
}
