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

  // Android에서 보낸 Map 데이터를 UserInfo로 변환
  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePictureUrl: map['profilePictureUrl'],
    );
  }

  // UserInfo를 Map으로 변환 (필요시 사용)
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
