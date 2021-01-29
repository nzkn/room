class User {
  final String id;
  final String fullName;
  final String email;
  final String image;

  const User(this.id, this.fullName, this.email, {this.image});

  User.fromJson(Map<String, dynamic> m)
      : id = m['id'],
        fullName = m['fullName'],
        email = m['email'],
        image = m['image'];

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'fullName' : fullName,
      'email' : email,
      'image' : image,
    };
  }
}
