import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prov/models/image_data.dart';
import 'package:prov/states/favorite.dart';
import 'package:prov/states/images.dart';
import 'package:prov/states/trash.dart';
import 'package:provider/provider.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ImageData;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(args.title,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          ),
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Hero(
                tag: args.imageUrl,
                child: Image.network(
                  args.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  errorBuilder: (_, __, ___) {
                    return Image.file(
                      File(args.imageUrl),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                    );
                  },
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Consumer3<Favorites, Trash, Images>(
                          builder: (_, fav, trash, imgs, child) {
                        return Row(
                          children: [
                            if (!trash.isInTrash(args))
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    if (fav.isFavorite(args)) {
                                      fav.removeFavorite(args);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Imagem desfavoritada',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 1000),
                                          backgroundColor: Colors.black,
                                        ),
                                      );
                                    } else {
                                      fav.addFavorite(args);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Imagem favoritada',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 1000),
                                          backgroundColor: Colors.black,
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    fav.isFavorite(args)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    size: 30,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 20),
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  if (!trash.isInTrash(args)) {
                                    trash.addToTrash(args);
                                    imgs.removeImage(args);
                                    fav.removeFavorite(args);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Imagem movida para lixeira',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 1000),
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                  } else {
                                    trash.removeFromTrash(args);
                                    imgs.addImage(args);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Imagem removido da lixeira',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 1000),
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  trash.isInTrash(args)
                                      ? Icons.delete
                                      : Icons.delete_outline,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SingleChildScrollView(
                        child: Text(args.description,
                            style: const TextStyle(
                              fontSize: 20,
                            ))),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
