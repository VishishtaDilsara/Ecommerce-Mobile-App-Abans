import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_abans/controllers/product_controller.dart';
import 'package:my_abans/controllers/storage_controller.dart';
import 'package:my_abans/models/product_model.dart';
import 'package:my_abans/utils/custom_dialogs.dart';
import 'package:uuid/uuid.dart';

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

  void clearStates() {
    _productNameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _selectedCategoryId = null;
    _pickedImages.clear();
    notifyListeners();
  }

  Future<void> publishProduct(BuildContext context) async {
    if (_productNameController.text.trim().isEmpty) {
      CustomDialogs.showErrorSnackBar(context, 'Please Add Product Name');
    } else if (_descriptionController.text.trim().isEmpty) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please Add Product Description',
      );
    } else if (_selectedCategoryId == null) {
      CustomDialogs.showErrorSnackBar(
        context,
        'Please Select Product Category',
      );
    } else if (_priceController.text.trim().isEmpty) {
      CustomDialogs.showErrorSnackBar(context, 'Please Add Product Prize');
    } else if (_pickedImages.isEmpty) {
      CustomDialogs.showErrorSnackBar(context, 'Please Add atleast one image');
    } else {
      List<String> imageUrls = [];
      EasyLoading.show();

      for (var file in _pickedImages) {
        final imageUrl = await StorageController().uploadFile(
          file,
          'Product Images',
        );
        if (imageUrl != null) {
          imageUrls.add(imageUrl);
        }
      }
      final product = ProductModel(
        id: Uuid().v4(),
        categoryId: _selectedCategoryId!,
        description: _descriptionController.text.trim(),
        images: imageUrls,
        name: _productNameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
      );
      final isSuccess = await ProductController().publishProduct(product);
      if (isSuccess) {
        clearStates();
        CustomDialogs.showSuccessSnackBar(
          context,
          'Product Publish Successfull',
        );
      } else {
        CustomDialogs.showErrorSnackBar(
          context,
          'Product Image Publish Failed',
        );
      }
      EasyLoading.dismiss();
    }
  }
}
