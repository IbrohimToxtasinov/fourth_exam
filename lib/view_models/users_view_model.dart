import 'package:fifth_exam/data/models/my_response/my_response_model.dart';
import 'package:fifth_exam/data/models/users/users_model.dart';
import 'package:fifth_exam/data/repositories/users_repository.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel({required UserRepository userRepository}) {
    _userRepository = userRepository;
    fetchAllUsers();
  }

  late UserRepository _userRepository;
  List<UserModel> user = [];
  String errorForUI = "";

  fetchAllUsers() async {
    MyResponse response = await _userRepository.getAllUsers();
    if (response.error.isEmpty) {
      user = response.data as List<UserModel>;
    } else {
      errorForUI = response.error;
    }
    notifyListeners();
  }
}
