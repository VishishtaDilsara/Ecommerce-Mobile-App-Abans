import 'package:flutter/material.dart';
import 'package:my_abans/components/custom_text_field.dart';
import 'package:my_abans/providers/cart_provider.dart';
import 'package:my_abans/utils/custom_colors.dart';
import 'package:my_abans/utils/navigation_manager.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Payment'),
            backgroundColor: CustomColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                CustomTextField(
                  label: 'Name',
                  controller: cartProvider.nameController,
                ),
                CustomTextField(
                  label: 'Address',
                  controller: cartProvider.addressController,
                ),
                CustomTextField(
                  label: 'Phone Number',
                  controller: cartProvider.phoneController,
                ),
                SizedBox(height: 16),
                Divider(),
                Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12),
                MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  removeTop: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartProvider.cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${cartItem.product.name} x${cartItem.quantity}',
                                    maxLines: 2,
                                  ),
                                ),
                                Text(
                                  'LKR ${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
                                ),
                              ],
                            ),
                            Divider(color: Colors.grey.shade200),
                          ],
                        ),
                      );
                    },
                  ),
                ),
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
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},

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
                      child: Text('Pay Now'),
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
