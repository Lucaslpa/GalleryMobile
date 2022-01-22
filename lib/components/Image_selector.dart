import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prov/models/image_data.dart';

class ImageSelector extends StatelessWidget {
  final ImageData imageData;
  const ImageSelector({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/imageView',
            arguments: imageData,
          );
        },
        child: Hero(
            tag: imageData.imageUrl,
            child: Image.network(
              imageData.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Image.file(File(imageData.imageUrl));
              },
            )));
  }
}
