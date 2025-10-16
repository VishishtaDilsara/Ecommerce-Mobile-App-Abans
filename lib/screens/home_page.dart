import 'package:flutter/material.dart';
import 'package:my_abans/controllers/auth_controller.dart';
import 'package:my_abans/data/categories.dart';
import 'package:my_abans/models/product_model.dart';
import 'package:my_abans/providers/product_provider.dart';
import 'package:my_abans/providers/user_provider.dart';
import 'package:my_abans/screens/admin/product_add_screen.dart';
import 'package:my_abans/utils/custom_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_abans/utils/navigation_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductModel>> _productFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _productFuture = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            NavigationManager.goTo(context, ProductAddScreen());
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              CustomColors.primaryColor,
                            ),
                          ),
                          icon: Icon(
                            Icons.menu_rounded,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        Image.asset('assets/images/text_logo.png', height: 25),
                        IconButton(
                          onPressed: () {
                            AuthController().signOut(context);
                          },

                          icon: Icon(Icons.more_vert_rounded, size: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    viewportFraction: 1,
                  ),
                  items:
                      [
                        'https://buyabans.com/cdn-cgi/imagedelivery/OgVIyabXh1YHxwM0lBwqgA/slider_images/Default/aiBY7cyHVfRe4OzgkJtUwDm2LnbjYHLS0Ihs2UOR.webp/public',
                        'https://buyabans.com/cdn-cgi/imagedelivery/OgVIyabXh1YHxwM0lBwqgA/home_banner_images/J86zWcODbjDzMST5Ceq8Iu0FXkVNLi0RhZhNnOiq.webp/public',
                        'https://buyabans.com/cdn-cgi/imagedelivery/OgVIyabXh1YHxwM0lBwqgA/home_banner_images/1kpFoox5aAeTcQGqVG4t90obutoTXmKscfvK7U8I.webp/public',
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(i),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),
                SizedBox(height: 22),
                RichText(
                  text: TextSpan(
                    text: 'Hello ${userProvider.user?.name},',
                    style: TextStyle(
                      color: CustomColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    children: [
                      TextSpan(
                        text: ' What are you\nlooking for?',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: Categories.list
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(e.icon, color: CustomColors.primaryColor),
                                SizedBox(width: 12),
                                Text(
                                  e.name,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Latest Products',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: FutureBuilder(
                      future: _productFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError ||
                            snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return Text('No Products');
                        }

                        final products = snapshot.data!;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.6,
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                              ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          product.images.first,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'LKR ${product.price.toInt()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
