import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputProvider extends ChangeNotifier {
  FileImage? _image;
  String? _imageUrl;
  File? _imageFile;
  final picker = ImagePicker();

  FileImage? get image => _image;
  String? get imageUrl => _imageUrl;
  File? get imageFile => _imageFile;

  set imageUrl(String? imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  void resetImage() {
    _image = null;
    _imageFile = null;
    notifyListeners();
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _image = FileImage(_imageFile!);
      await uploadImageToFirebase(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImageToFirebase(String file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('image/$fileName.jpg');
    UploadTask uploadTask = firebaseStorageRef.putFile(File(file));
    await uploadTask.whenComplete(() async {
      _imageUrl = await firebaseStorageRef.getDownloadURL();
      notifyListeners();
    });
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select image...'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take Photo'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Open Gallery'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}