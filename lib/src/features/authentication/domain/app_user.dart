// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:muraita_2_0/src/constants/strings.dart';

///to add field
///lastActive
///bool active/inactive

class AppUser {
  AppUser({
    required this.id,
    required this.uid,
    this.displayName = kEmptyString,
    required this.phoneNumber,
    required this.userLocation,
    this.email,
    this.emailVerified = false,
    this.photoUrl = kEmptyString,
    this.birthDate = kEmptyString,
    this.providedData = kEmptyString,
    this.lastActive,
    this.success = true,
  });
  final String id;
  final String uid;
  final String? displayName;
  final String phoneNumber;
  final String userLocation;
  final String? email;
  final bool? emailVerified;
  final String? photoUrl;
  final String? birthDate;
  final String? providedData;
  final DateTime? lastActive;
  final bool? success;

  factory AppUser.fromMap(Map<String, dynamic> map, String userId) {
    return AppUser(
      id: userId,
      uid: map['uid'],
      displayName: map['displayName'],
      phoneNumber: map['phoneNumber'],
      userLocation: map['userLocation'],
      email: map['email'],
      emailVerified: map['emailVerified'],
      photoUrl: map['photoUrl'],
      birthDate: map['birthDate'],
      providedData: map['providedData'],
      lastActive: map['lastActive'].toDate(),
      success: map['success'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'userLocation': userLocation,
      'email': email,
      'emailVerified': emailVerified,
      'photoUrl': photoUrl,
      'birthDate': birthDate,
      'providedData': providedData,
      'lastActive': lastActive,
      'success': success,
    };
  }

  @override
  String toString() {
    return 'AppUser(id: $id, uid: $uid, displayName: $displayName, phoneNumber: $phoneNumber, userLocation: $userLocation, email: $email, emailVerified: $emailVerified, photoUrl: $photoUrl, birthDate: $birthDate, providedData: $providedData, lastActive: $lastActive success: $success)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.id == id &&
        other.uid == uid &&
        other.displayName == displayName &&
        other.phoneNumber == phoneNumber &&
        other.userLocation == userLocation &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.photoUrl == photoUrl &&
        other.birthDate == birthDate &&
        other.providedData == providedData &&
        other.lastActive == lastActive &&
        other.success == success;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        displayName.hashCode ^
        phoneNumber.hashCode ^
        userLocation.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        photoUrl.hashCode ^
        birthDate.hashCode ^
        providedData.hashCode ^
        lastActive.hashCode ^
        success.hashCode;
  }

  AppUser copyWith({
    String? id,
    String? uid,
    String? displayName,
    String? phoneNumber,
    String? userLocation,
    String? email,
    bool? emailVerified,
    String? photoUrl,
    String? birthDate,
    String? providedData,
    DateTime? lastActive,
    bool? success,
  }) {
    return AppUser(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userLocation: userLocation ?? this.userLocation,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      photoUrl: photoUrl ?? this.photoUrl,
      birthDate: birthDate ?? this.birthDate,
      providedData: providedData ?? this.providedData,
      lastActive: lastActive ?? this.lastActive,
      success: success ?? this.success,
    );
  }
}
