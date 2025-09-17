class UserInfo {
  final String id;
  final String name;
  final String email;
  final String? profilePictureUrl;

  const UserInfo({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
  });


  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePictureUrl: map['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  @override
  String toString() {
    return 'UserInfo{id: $id, name: $name, email: $email, profilePictureUrl: $profilePictureUrl}';
  }
}
