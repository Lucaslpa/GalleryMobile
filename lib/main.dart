import 'package:flutter/material.dart';
import 'package:prov/Screens/create_new_picture.dart';
import 'package:prov/Screens/favorites_view.dart';
import 'package:prov/Screens/trash_view.dart';

import 'package:prov/states/favorite.dart';
import 'package:prov/states/images.dart';
import 'package:prov/states/trash.dart';

import 'package:provider/provider.dart';

import 'package:prov/Screens/image_view.dart';
import 'package:prov/Screens/image_views.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Images(),
        ),
        ChangeNotifierProvider(
          create: (_) => Trash(),
        ),
        ChangeNotifierProvider(
          create: (_) => Favorites(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery',
      theme: ThemeData(
          colorScheme: const ColorScheme(
        primary: Colors.red,
        primaryVariant: Colors.black,
        secondary: Colors.red,
        secondaryVariant: Colors.red,
        surface: Colors.white,
        background: Colors.white,
        error: Colors.red,
        onPrimary: Colors.black,
        onSecondary: Colors.red,
        onSurface: Colors.white,
        onBackground: Colors.red,
        onError: Colors.red,
        brightness: Brightness.light,
      )),
      home: const MyHomePage(title: 'Gallery'),
      routes: {
        '/imageView': (
          _,
        ) =>
            const ImageView(),
        '/Favorites': (_) {
          return const FavoritesScreen();
        },
        '/Trash': (_) {
          return const TrashScreen();
        },
        '/CreateNewPicture': (_) {
          return const CreateNewPictureScreen();
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primaryVariant),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/CreateNewPicture');
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/Favorites',
                        );
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/Trash',
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                )
              ],
            )),
        body: const ImageViews());
  }
}
