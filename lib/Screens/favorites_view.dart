import 'package:flutter/material.dart';
import 'package:prov/components/Image_selector.dart';
import 'package:prov/states/favorite.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Consumer<Favorites>(builder: (_, favorites, child) {
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
              ...favorites.favorites
                  .map((data) => ImageSelector(imageData: data)),
            ],
          );
        }));
  }
}
