import 'package:fifth_exam/data/models/my_response/my_response_model.dart';
import 'package:fifth_exam/data/services/api_service/api_service.dart';

class UserRepository {
  UserRepository({required this.apiService});
  ApiService apiService;

  Future<MyResponse> getAllUsers() => apiService.getAllUsers();
}
