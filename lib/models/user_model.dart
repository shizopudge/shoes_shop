import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String avatar;
  final String uid;
  final bool isAuthenticated; // if guest or not
  UserModel({
    required this.name,
    required this.avatar,
    required this.uid,
    required this.isAuthenticated,
  });

  UserModel copyWith({
    String? name,
    String? avatar,
    String? uid,
    bool? isAuthenticated,
  }) {
    return UserModel(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      uid: map['uid'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, avatar: $avatar, uid: $uid, isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.avatar == avatar &&
        other.uid == uid &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        avatar.hashCode ^
        uid.hashCode ^
        isAuthenticated.hashCode;
  }
}
