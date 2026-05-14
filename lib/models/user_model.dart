import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String? referralCode;
  final String? avatarUrl;
  final bool isVerified;
  final List<String> wishlist;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    this.referralCode,
    this.avatarUrl,
    this.isVerified = false,
    this.wishlist = const [],
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'full_name': fullName,
      'email': email,
      'referral_code': referralCode,
      'avatar_url': avatarUrl,
      'is_verified': isVerified,
      'wishlist': wishlist,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      referralCode: map['referral_code'],
      avatarUrl: map['avatar_url'],
      isVerified: map['is_verified'] ?? false,
      wishlist: List<String>.from(map['wishlist'] ?? []),
      createdAt: (map['created_at'] as Timestamp).toDate(),
    );
  }
}
