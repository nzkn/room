class User {
  final String id;
  final String fullName;
  final String email;

  const User(this.id, this.fullName, this.email);

  User.fromJson(Map<String, dynamic> m)
      : id = m['id'] ?? '',
        fullName = m['fullName'] ?? '',
        email = m['email'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'fullName' : fullName,
      'email' : email,
    };
  }
}
