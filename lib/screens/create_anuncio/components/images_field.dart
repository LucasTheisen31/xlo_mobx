import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xlo_mobx/screens/create_anuncio/components/image_source_modal.dart';

class ImagesField extends StatelessWidget {
  const ImagesField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //funcao callback para receber a imagem selecionada
    void onImageSelected(File image) {
      Navigator.of(context).pop();
    }

    return Container(
      height: 120,
      color: Colors.grey[200],
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        itemBuilder: (context, index) => GestureDetector(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: GestureDetector(
              onTap: () {
                //se for android ou ios exibe um menu diferente de acordo com a plataforma
                if (Platform.isAndroid) {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      context: context,
                      builder: (context) =>
                          ImageSourceModal(onImageSelected: onImageSelected));
                } else {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) =>
                          ImageSourceModal(onImageSelected: onImageSelected));
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
          ),
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
      ),
    );
  }
}
