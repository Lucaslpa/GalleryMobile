import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prov/models/image_data.dart';
import 'package:prov/states/images.dart';
import 'package:provider/provider.dart';

class CreateNewPictureScreen extends StatefulWidget {
  const CreateNewPictureScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPictureScreenState createState() => _CreateNewPictureScreenState();
}

class _CreateNewPictureScreenState extends State<CreateNewPictureScreen> {
  final ImageData _imageData =
      ImageData(imageUrl: '', description: '', title: '');
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Adicionar uma nova imagem'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
                child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        await showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text(
                                          'Escolha uma opção de selecionar imagem'),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        child: const Text(
                                            'Selecionar do celular',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () async {
                                          await _imageData
                                              .pickImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Tirar foto',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () async {
                                          await _imageData.pickImageNewCapPic();
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                        setState(() {});
                      },
                      child: _imageData.imageUrl == ''
                          ? const Text(
                              'Nova Foto',
                              style: TextStyle(color: Colors.black),
                            )
                          : Image.file(
                              File(_imageData.imageUrl),
                              height: 200,
                              width: 200,
                            )),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  onChanged: (value) => _imageData.title = value,
                  decoration: const InputDecoration(
                    labelText: 'Nome da imagem',
                  ),
                ),
                TextFormField(
                  onChanged: (value) => _imageData.description = value,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: Consumer<Images>(
                    builder: (_, imgs, child) {
                      return ElevatedButton(
                        child: _isLoading == true
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Adicionar imagem',
                                style: TextStyle(color: Colors.white),
                              ),
                        onPressed: () {
                          print(_imageData.imageUrl);
                          if (_imageData.imageUrl.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('Erro'),
                                    content: const Text(
                                        'Você precisa selecionar uma imagem'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Ok'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                            return;
                          } else if (_imageData.title.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('Erro'),
                                    content: const Text(
                                        'Você precisa passar um nome para a imagem'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Ok'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });

                            return;
                          } else if (_imageData.description.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('Erro'),
                                    content: const Text(
                                        'Você precisa passar uma  descrição'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Ok'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });

                            return;
                          }
                          setState(() {
                            _isLoading = true;
                            imgs.addImage(_imageData);
                            Navigator.of(context).pop();
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
