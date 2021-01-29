class Message {
  final String message;
  final String userId;
  final String nickname;
  final String createdAt;

  Message(this.message, this.userId, this.nickname, this.createdAt);

  Message.fromJson(Map<String, dynamic> m)
      : message = m['message'],
        userId = m['userId'],
        nickname = m['nickname'],
        createdAt = m['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'message' : message,
      'userId' : userId,
      'nickname' : nickname,
      'createdAt' : createdAt,
    };
  }
}