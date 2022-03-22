class User {
  final String name;
  final String username;
  final String profileImage;
  final String lastAccessTime;
  final String followers;
  final String following;
  final bool isNewUser;
  final bool microphoneOn;
  final bool isSpeaking;

  User(
      {required this.name,
      required this.username,
      required this.profileImage,
      required this.followers,
      required this.following,
      required this.lastAccessTime,
      required this.isNewUser,
      required this.microphoneOn,
      required this.isSpeaking});

  factory User.fromJson(json) {
    return User(
      name: json['name'] ?? "",
      username: json['username'] ?? "",
      profileImage: json['profileImage'] ?? "",
      lastAccessTime: json['lastAccessTime'] ?? "",
      followers: json['followers'] ?? "",
      following: json['following'] ?? '',
      isNewUser: json['isNewUser'] ?? false,
      microphoneOn: json['microphoneOn'] ?? false,
      isSpeaking: json['isSpeaking'] ?? false,
    );
  }
}
