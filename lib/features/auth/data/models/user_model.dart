class UserModel {
  final String uid;
  final String email;
  final String? fcmToken;

  UserModel({
    required this.uid,
    required this.email,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fcmToken': fcmToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      fcmToken: map['fcmToken'] as String?,
    );
  }
}
