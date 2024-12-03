import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/menu_item.dart';
import 'package:food_ordering_app/services/menu_item_service.dart';
import 'package:food_ordering_app/widgets/image_upload.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdateMenuItemsWidget {
  //final _productInstance = ProductServices();

  void addEditProductDialog(BuildContext context, {MenuItem? menuItem}) {
    final TextEditingController itemNameController =
        TextEditingController(text: menuItem?.name);
    final TextEditingController itemDescriptionController =
        TextEditingController(text: menuItem?.description);
    final TextEditingController itemPriceController =
        TextEditingController(text: menuItem?.price.toString());
    String downloadUrl = menuItem?.image ?? "";

    void _updateDownloadUrl(String url) {
      downloadUrl = url;
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            title: Text(
              menuItem == null ? "Add Menu Item" : "Update Menu Item",
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    TextField(
                      controller: itemNameController,
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        label: Text(
                          "Name",
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: itemDescriptionController,
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        label: Text(
                          "Description",
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: itemPriceController,
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                        label: Text(
                          "Price",
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Image upload
                    ImageUpload(
                      onUploadComplete: _updateDownloadUrl,
                      currentImageUrl: menuItem?.image,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 243, 106, 106))),
                  onPressed: () {
                    MenuItemService().deleteMenuItem(context, menuItem!.id!);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 190, 190, 190))),
                  child: const Text(
                    "cancel",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () async {
                    log(downloadUrl.toString());
                    final MenuItem newItem = MenuItem(
                        name: itemNameController.text,
                        description: itemDescriptionController.text,
                        price: double.parse(itemPriceController.text),
                        image: downloadUrl);

                    if (menuItem == null) {
                      await MenuItemService().createMenuItem(context, newItem);
                    } else {
                      await MenuItemService()
                          .updateMenuItem(context, menuItem.id!, newItem);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "save",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))
            ],
          );
        });
  }
}
