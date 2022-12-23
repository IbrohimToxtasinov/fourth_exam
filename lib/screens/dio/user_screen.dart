import 'package:fifth_exam/data/repositories/users_repository.dart';
import 'package:fifth_exam/data/services/api_service/api_service.dart';
import 'package:fifth_exam/view_models/users_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: ChangeNotifierProvider(
            create: (context) => UserViewModel(
                userRepository: UserRepository(apiService: ApiService())),
            builder: (context, child) {
              var user = context.watch<UserViewModel>();
              if (user.errorForUI.isNotEmpty) {
                return Center(
                  child: Text(user.errorForUI),
                );
              }
              if (user.userList.isNotEmpty) {
                return ListView.builder(
                  itemCount: user.userList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(user.userList[index].avatarUrl),
                            )),
                      ),
                      title: Text(user.userList[index].name),
                      subtitle: Text(user.userList[index].username),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
