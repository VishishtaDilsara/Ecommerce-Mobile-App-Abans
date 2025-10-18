import 'package:flutter/material.dart';
import 'package:my_abans/components/custom_button.dart';
import 'package:my_abans/data/categories.dart';
import 'package:my_abans/models/cart_model.dart';
import 'package:my_abans/providers/cart_provider.dart';
import 'package:my_abans/providers/product_provider.dart';
import 'package:my_abans/screens/cart_view.dart';
import 'package:my_abans/utils/custom_colors.dart';
import 'package:my_abans/utils/navigation_manager.dart';
import 'package:provider/provider.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final product = productProvider.selectedProduct;
        return Scaffold(
          backgroundColor: Colors.white,

          body: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.width,
                child: Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        image: DecorationImage(
                          image: NetworkImage(
                            product?.images[imageIndex] ?? '',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: product!.images
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imageIndex = product.images.indexOf(e);
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            imageIndex ==
                                                product.images.indexOf(e)
                                            ? CustomColors.primaryColor
                                            : Colors.grey.shade600,
                                        width: 2,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(e),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SafeArea(
                      child: BackButton(
                        color: Colors.white,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.black.withAlpha(100),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return cartProvider.cartItems.isNotEmpty
                              ? SafeArea(
                                  child: GestureDetector(
                                    onTap: () {
                                      NavigationManager.goTo(
                                        context,
                                        CartView(),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Badge.count(
                                        count: cartProvider.cartItems.length,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black38,
                                          child: Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(product.description),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: CustomColors.primaryColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            Categories.list
                                .firstWhere(
                                  (element) => element.id == product.categoryId,
                                )
                                .name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'LKR ${product.price.toInt()}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Quantity:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                productProvider.decrementProductQuantity();
                              },
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor:
                                    productProvider.selectedProductQuantity == 1
                                    ? Colors.grey.shade300
                                    : CustomColors.primaryColor,
                                child: Icon(Icons.remove, color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              '${productProvider.selectedProductQuantity}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                productProvider.incrementProductQuantity();
                              },
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: CustomColors.primaryColor,
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 80,
                    child: CustomButton(
                      text: 'Add to Cart',
                      onTap: () {
                        cartProvider.addToCart(
                          CartModel(
                            product: product,
                            quantity: productProvider.selectedProductQuantity,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
