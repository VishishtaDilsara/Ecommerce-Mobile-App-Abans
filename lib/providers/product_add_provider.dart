import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddProvider extends ChangeNotifier {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  TextEditingController get productNameController => _productNameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get priceController => _priceController;

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  List<File> _pickedImages = [];
  List<File> get pickedImages => _pickedImages;

  void setProductCategory(String id) {
    _selectedCategoryId = id;
    notifyListeners();
  }

  Future<void> addImages() async {
    final imagePicker = ImagePicker();
    final limit = 5 - _pickedImages.length;
    if (limit == 1) {
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 600,
      );
      if (image != null) {
        _pickedImages.add(File(image.path));
        notifyListeners();
      }
    } else {
      final images = await imagePicker.pickMultiImage(
        limit: limit,
        imageQuality: 70,
        maxHeight: 600,
      );

      _pickedImages.addAll(images.map((e) => File(e.path)));
    }

    notifyListeners();
  }

  void removeImage(File image) {
    _pickedImages.remove(image);
    notifyListeners();
  }
}
