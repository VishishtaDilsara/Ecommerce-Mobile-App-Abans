import 'package:flutter/material.dart';
import 'package:my_abans/controllers/user_controller.dart';
import 'package:my_abans/models/user_model.dart';
import 'package:my_abans/screens/home_page.dart';
import 'package:my_abans/utils/navigation_manager.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  void setUserModel(UserModel userModel) {
    _user = userModel;
    notifyListeners();
  }

  Future<void> fetchUserData(BuildContext context) async {
    final userModel = await UserController().fetchUserData();
    if (userModel != null) {
      _user = userModel;
      NavigationManager.goWithReplace(context, HomePage());
    }
  }
}
