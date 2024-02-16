final class UserModel {
  final String? email;
  final num? id;
  final String? token;
  final String? avatar;
  final String? firstName;
  final String? lastName;

  UserModel({
    required this.email,
    required this.token,
    this.id,
    this.avatar,
    this.firstName,
    this.lastName,
  });

  factory UserModel.empty() => UserModel(
        email: null,
        id: null,
        token: null,
        firstName: null,
        lastName: null,
        avatar: null,
      );

  UserModel copyWith({
    String? email,
    num? id,
    String? token,
    String? avatar,
    String? firstName,
    String? lastName,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
      avatar: avatar ?? this.avatar,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      id: map['id'] != null ? map['id'] as num : null,
      token: map['token'] != null ? map['token'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
    );
  }
}
