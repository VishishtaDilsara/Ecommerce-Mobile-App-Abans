import 'package:flutter/material.dart';
import 'package:my_abans/controllers/auth_controller.dart';
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
              ],
            ),
          ),
        );
      },
    );
  }
}
