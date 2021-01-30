class Message {
  final String message;
  final String userId;
  final String nickname;
  final String createdAt;
  final String image;

  Message(this.userId, this.nickname, this.createdAt, {this.message, this.image});

  Message.fromJson(Map<String, dynamic> m)
      : message = m['message'],
        userId = m['userId'],
        nickname = m['nickname'],
        createdAt = m['createdAt'],
        image = m['image'];

  Map<String, dynamic> toJson() {
    return {
      'message' : message,
      'userId' : userId,
      'nickname' : nickname,
      'createdAt' : createdAt,
      'image' : image,
    };
  }
}