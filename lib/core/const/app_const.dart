import 'package:flutter/material.dart';

class LocalPath {
  static String androidDownloadDir(String fileName) =>
      '/storage/emulated/0/Download/$fileName';
}

const defaultFullBodyPadding = EdgeInsets.all(20);
const coverPhotoSize = Size(700, 300);
const defaultBorderRadius = BorderRadius.all(Radius.circular(10));
const defaultBorderRR =
    RoundedRectangleBorder(borderRadius: defaultBorderRadius);

const String defErrorMsg = 'Something went wrong';
