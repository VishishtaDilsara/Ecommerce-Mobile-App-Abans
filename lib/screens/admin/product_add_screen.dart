import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_abans/components/custom_button.dart';
import 'package:my_abans/components/custom_text_field.dart';
import 'package:my_abans/data/categories.dart';
import 'package:my_abans/providers/product_add_provider.dart';
import 'package:my_abans/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductAddProvider>(
      builder: (context, productAddProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            foregroundColor: Colors.white,
            title: Text('Add Product'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Product Name',
                    controller: productAddProvider.productNameController,
                  ),
                  CustomTextField(
                    label: 'Description',
                    maxLines: 5,
                    controller: productAddProvider.descriptionController,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Product Category'),
                  ),

                  Wrap(
                    children: Categories.list.map((e) {
                      final isSelected =
                          productAddProvider.selectedCategoryId == e.id;
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: GestureDetector(
                          onTap: () {
                            productAddProvider.setProductCategory(e.id);
                          },
                          child: Chip(
                            backgroundColor: isSelected
                                ? Colors.deepPurple.shade100
                                : Colors.grey.shade200,
                            avatar: Icon(e.icon),
                            label: Text(e.name),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 12),

                  CustomTextField(
                    label: 'Price',
                    keyboardType: TextInputType.number,
                    prefixText: 'LKR ',
                    controller: productAddProvider.priceController,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Product Images'),
                        if (productAddProvider.pickedImages.length < 5)
                          FilledButton(
                            onPressed: () {
                              productAddProvider.addImages();
                            },
                            child: Text('Add Image'),
                          ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: productAddProvider.pickedImages.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: FileImage(e),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: GestureDetector(
                                    onTap: () {
                                      productAddProvider.removeImage(e);
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.deepPurple,
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: CustomButton(text: 'Publish Product', onTap: () {}),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
