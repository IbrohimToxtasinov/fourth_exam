import 'package:fifth_exam/data/repositories/users_repository.dart';
import 'package:fifth_exam/data/services/api_service/api_service.dart';
import 'package:fifth_exam/view_models/users_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users Screen"),
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
              if (user.user.isNotEmpty) {
                return ListView.builder(
                  itemCount: user.user.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shadowColor: Colors.black,
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(user.user[index].avatarUrl),
                              )),
                        ),
                        title: Text(user.user[index].name),
                        subtitle: Text(user.user[index].username),
                      ),
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
