import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prov/components/Image_selector.dart';
import 'package:prov/models/image_data.dart';
import 'package:prov/states/images.dart';
import 'package:provider/provider.dart';

class ImageViews extends StatefulWidget {
  const ImageViews({Key? key}) : super(key: key);

  @override
  State<ImageViews> createState() => _ImageViewsState();
}

class _ImageViewsState extends State<ImageViews> {
  List<ImageData> dataImages = [];

  Future<List<dynamic>> readJson() async {
    final String response = await rootBundle.loadString('lib/assets/data.json');
    final data = await jsonDecode(response)['Data'];
    return data;
  }

  Future<void> getData(
      Function(List<ImageData> images) addImagesToState) async {
    final data = await readJson();

    addImagesToState(data.map((json) => ImageData.fromJson(json)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Images>(builder: (context, images, child) {
      return FutureBuilder(
        future: getData(images.addImages),
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
              child: Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return GridView(
            padding: const EdgeInsets.all(10),
            clipBehavior: Clip.hardEdge,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                childAspectRatio: 3.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20.0,
                mainAxisExtent: 180),
            children: [
              ...images.images.map((data) => ImageSelector(imageData: data)),
            ],
          );
        },
      );
    });
  }
}
