import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'firestore_path.dart';

class FirebaseStorageService {
  FirebaseStorageService({required this.uid});
  final String uid;

  /// Upload an avatar from file
  Future<String> uploadAvatar({
    required File file,
  }) async {
    return await upload(
      file: file,
      path: FirestorePath.avatar(uid) + '/avatar.png',
      contentType: 'image/png',
    );
  }

  /// Generic file upload for any [path] and [contentType]
  Future<String> upload({
    required File file,
    required String path,
    required String contentType,
  }) async {
    print('uploading to: $path');
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageReference.putFile(
        file, SettableMetadata(contentType: contentType));
    final result = await uploadTask;
    String url = await result.ref.getDownloadURL();
    // uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) async {
    //   print('Snapshot state: ${snapshot.state}'); // paused, running, complete
    //   print('Progress: ${snapshot.totalBytes / snapshot.bytesTransferred}');
    //   return url = await snapshot.ref.getDownloadURL();
    // }, onError: (Object e) {
    //   print('upload error code : $e'); // FirebaseException
    // });

    print("hereurl" + url);
    return url;
  }
}
