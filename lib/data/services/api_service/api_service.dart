import 'package:dio/dio.dart';
import 'package:fifth_exam/data/models/my_response/my_response_model.dart';
import 'package:fifth_exam/data/models/users/users_model.dart';
import 'package:fifth_exam/data/services/api_service/api_client.dart';

class ApiService extends ApiClient {
  Future<MyResponse> getAllUsers() async {
    MyResponse myResponse = MyResponse(error: "");
    try {
      Response response = await dio.get("${dio.options.baseUrl}/users");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        myResponse.data =
            (response.data as List).map((e) => UserModel.fromJson(e)).toList();
      }
    } catch (error) {
      myResponse = MyResponse(
        error: error.toString(),
      );
    }
    return myResponse;
  }
}
