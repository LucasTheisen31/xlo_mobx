import 'dart:io';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceModal extends StatelessWidget {
  const ImageSourceModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              onTap: () {},
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.image),
              title: Text('Galeria'),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        actions: [
          CupertinoListTile(
            onTap: () {},
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
          ),
          CupertinoListTile(
            onTap: () {},
            leading: Icon(Icons.image),
            title: Text('Galeria'),
          ),
        ],
      );
    }
  }
}
