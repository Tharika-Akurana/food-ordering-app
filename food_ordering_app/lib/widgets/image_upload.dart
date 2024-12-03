import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  final Function(String) onUploadComplete;
  final String? currentImageUrl;

  ImageUpload({required this.onUploadComplete, this.currentImageUrl});

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: image != null
                ? Image.file(
                    File(image!.path),
                    fit: BoxFit.cover,
                  )
                : widget.currentImageUrl != null
                    ? Image.network(
                        widget.currentImageUrl!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.camera_alt_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () async {
            if (image != null) {
              final ref = FirebaseStorage.instance.ref().child(
                  "food_order/menu_items/${image!.path.split('/').last}");
              final uploadTask = ref.putFile(image!);
              final snapshot = await uploadTask.whenComplete(() => null);
              final downloadUrl = await snapshot.ref.getDownloadURL();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Image uploaded successfully")));
              widget.onUploadComplete(downloadUrl);
            }
          },
          child: const Text('Upload Image'),
        ),
      ],
    );
  }
}
