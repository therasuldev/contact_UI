class User {
  final String userName;
  final String userImage;

  User({required this.userName, required this.userImage});

  factory User.fromJson(Map<String, dynamic> json) => User(
        userName: json["login"],
        userImage: json["avatar_url"],
      );
}
