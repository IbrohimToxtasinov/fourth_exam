class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.state,
    required this.avatarUrl,
  });

  final int id;
  final String username;
  final String name;
  final String state;
  final String avatarUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] as int? ?? 0,
      username: json["username"] as String? ?? "",
      name: json["name"] as String? ?? "",
      state: json["state"] as String? ?? "",
      avatarUrl: json["avatar_url"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "state": state,
        "avatar_url": avatarUrl,
      };
}
