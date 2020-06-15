import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void  Function(File pickedImage ) imagePickFn;


  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final picker = ImagePicker();

  void _pickImage() async {
    final pickedImageFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: _pickedImage != null ?  FileImage(_pickedImage) : null,
      ),
      FlatButton.icon(
        textColor: Theme.of(context).primaryColor,
        onPressed: _pickImage,
        icon: Icon(Icons.image),
        label: Text('Add Image'),
      ),
    ]);
  }
}
