import 'dart:io';

import 'package:flutter/material.dart';

class ImageHelper {
  static Widget getImageWidget(String path, BoxFit fit) {
    if (path.startsWith('https')) {
      return Image.network(path, fit: fit);
    } else {
      return Image.file(File(path), fit: fit);
    }
  }
}