// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:muraita_2_0/src/constants/strings.dart';

class AppUser {
  AppUser({
    required this.id,
    required this.uid,
    this.displayName = kEmptyString,
    required this.phoneNumber,
    this.email = kEmptyString,
    this.emailVerified = false,
    this.photoUrl = kEmptyString,
    this.birthDate = kEmptyString,
    this.providedData = kEmptyString,
    this.success = true,
  });
  final String id;
  final String uid;
  final String? displayName;
  final String phoneNumber;
  final String? email;
  final bool? emailVerified;
  final String? photoUrl;
  final String? birthDate;
  final String? providedData;
  final bool? success;

  factory AppUser.fromMap(Map<String, dynamic> map, String userId) {
    return AppUser(
      id: userId,
      uid: map['uid'],
      displayName: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      emailVerified: map['emailVerified'],
      photoUrl: map['photoUrl'],
      birthDate: map['birthDate'],
      providedData: map['providedData'],
      success: map['success'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': displayName,
      'phoneNumber': phoneNumber,
      'email': email,
      'emailVerified': emailVerified,
      'photoUrl': photoUrl,
      'birthDate': birthDate,
      'providedData': providedData,
      'success': success,
    };
  }

  @override
  String toString() {
    return 'AppUser(id: $id, uid: $uid, displayName: $displayName, phoneNumber: $phoneNumber, email: $email, emailVerified: $emailVerified, photoUrl: $photoUrl, birthDate: $birthDate, providedData: $providedData, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.id == id &&
        other.uid == uid &&
        other.displayName == displayName &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.photoUrl == photoUrl &&
        other.birthDate == birthDate &&
        other.providedData == providedData &&
        other.success == success;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        displayName.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        photoUrl.hashCode ^
        birthDate.hashCode ^
        providedData.hashCode ^
        success.hashCode;
  }

  AppUser copyWith({
    String? id,
    String? uid,
    String? displayName,
    String? phoneNumber,
    String? email,
    bool? emailVerified,
    String? photoUrl,
    String? birthDate,
    String? providedData,
    bool? success,
  }) {
    return AppUser(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      photoUrl: photoUrl ?? this.photoUrl,
      birthDate: birthDate ?? this.birthDate,
      providedData: providedData ?? this.providedData,
      success: success ?? this.success,
    );
  }
}
