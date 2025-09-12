class User {
  String uid;
  String email;

  User({required this.uid, required this.email});

  // convert app user => json
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }

  // convert json => app user
  factory User.fromJson(Map<String, dynamic> jsonUser) {
    return User(uid: jsonUser['uid'], email: jsonUser['email']);
  }
}
