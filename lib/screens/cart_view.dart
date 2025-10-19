import 'package:flutter/material.dart';
import 'package:my_abans/providers/cart_provider.dart';
import 'package:my_abans/screens/payment_screen.dart';
import 'package:my_abans/utils/custom_colors.dart';
import 'package:my_abans/utils/navigation_manager.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('My Cart'),
            backgroundColor: CustomColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          body: cartProvider.cartItems.isEmpty
              ? Center(child: Text('No items in the cart'))
              : ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      cartItem.product.images.first,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  cartItem.product.name,
                                  maxLines: 2,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cartProvider.removeCartItem(index);
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cartProvider.decrementItemQuantity(
                                        index,
                                        context,
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: cartItem.quantity == 1
                                          ? Colors.grey
                                          : CustomColors.primaryColor,
                                      child: Icon(
                                        Icons.remove,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    cartItem.quantity.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () {
                                      cartProvider.incrementItemQuantity(
                                        index,
                                        context,
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor:
                                          CustomColors.primaryColor,
                                      child: Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                "LKR ${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: CustomColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "LKR ${cartProvider.cartItems.fold(0, (previousValue, element) => previousValue + element.product.price.toInt() * element.quantity)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        NavigationManager.goTo(context, PaymentScreen());
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Proceed to Checkout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
