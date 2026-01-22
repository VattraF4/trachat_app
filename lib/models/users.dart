class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  late DateTime lastActive;

  ChatUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.lastActive,
  });

  // Convert a ChatUser object to a Map
  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      lastActive: DateTime.parse(json['lastActive']),
    );
  }
  // Convert a Map to a ChatUser object
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'lastActive': lastActive,
    };
  }

  String lastDayActive() {
    return "${lastActive.day}/${lastActive.month}/${lastActive.year}";
  }

  //if lastActive is less than 7 days it will return true
  bool wasRecentlyActiveDays() {
    return lastActive.isAfter(DateTime.now().subtract(const Duration(days: 7)));
  }

  //if lastActive is less than 24 hours it will return true
  bool wasRecentlyActiveHours() {
    return DateTime.now().difference(lastActive).inHours < 24;
  }

}