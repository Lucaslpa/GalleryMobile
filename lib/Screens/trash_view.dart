import 'package:flutter/material.dart';
import 'package:prov/components/Image_selector.dart';
import 'package:prov/states/trash.dart';
import 'package:provider/provider.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lixeira'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Consumer<Trash>(builder: (_, trash, child) {
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
              ...trash.images.map((data) => ImageSelector(imageData: data)),
            ],
          );
        }));
  }
}
