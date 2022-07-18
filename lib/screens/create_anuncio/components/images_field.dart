import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xlo_mobx/screens/create_anuncio/components/image_source_modal.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  const ImagesField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    //funcao callback para receber a imagem selecionada
    void onImageSelected(File image) {
      createStore.images!.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          height: 120,
          color: Colors.grey[200],
          child: Observer(
            builder: (context) => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5),
              scrollDirection: Axis.horizontal,
              //createStore.images!.length + 1 para sempre exibir o Circle avatar de adicionar uma nova foto (<5 para so exibir a opçao de adicionar mais uma foto se tiver menos de 5 imagens)
              itemCount: createStore.images!.length < 5
                  ? createStore.images!.length + 1
                  : 5,
              itemBuilder: (context, index) {
                if (index == createStore.images?.length) {
                  //ou seja se for a ultima imagem
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: GestureDetector(
                      onTap: () {
                        //se for android ou ios exibe um menu diferente de acordo com a plataforma
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              context: context,
                              builder: (context) => ImageSourceModal(
                                  onImageSelected: onImageSelected));
                        } else {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) => ImageSourceModal(
                                  onImageSelected: onImageSelected));
                        }
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/camera-add.svg',
                              color: Colors.white,
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (builder) => ImageDialog(
                            image: createStore.images![index],
                            //funcao que vai ser o callback no ImageDialog
                            onDelete: () => createStore.images!.removeAt(index),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.transparent,
                        backgroundImage: createStore.images![index] is File
                            ? FileImage(
                                createStore.images![index],
                              )
                            : NetworkImage(createStore.images![index])
                                as ImageProvider,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Observer(
          builder: (context) {
            if (createStore.imagesError != null) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                child: Text(
                  createStore.imagesError!,
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),
              );
            } else
              return Container();
          },
        ),
      ],
    );
  }
}
