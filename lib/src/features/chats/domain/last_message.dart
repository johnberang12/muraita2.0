import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LastMessage {
  LastMessage({
    required this.senderId,
    required this.lastMessage,
    required this.dateSent,
    required this.isAcitvity,
    required this.isSeen,
  });
  final String senderId;
  final String lastMessage;
  final DateTime dateSent;
  final bool isAcitvity;
  final bool isSeen;

  //
  //

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'lastMessage': lastMessage,
      'dateSent': Timestamp.fromDate(dateSent),
      'isAcitvity': isAcitvity,
      'isSeen': isSeen,
    };
  }

  factory LastMessage.fromMap(Map<String, dynamic> map, String documentId) {
    return LastMessage(
      senderId: map['senderId'] as String,
      lastMessage: map['lastMessage'] as String,
      dateSent: (map['dateSent'] as Timestamp).toDate(),
      isAcitvity: map['isAcitvity'] as bool,
      isSeen: map['isSeen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  // factory LastMessage.fromJson(String source) =>
  //     LastMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LastMessage(senderId: $senderId, lastMessage: $lastMessage, dateSent: $dateSent, isAcitvity: $isAcitvity, isSeen: $isSeen)';
  }

  @override
  bool operator ==(covariant LastMessage other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.lastMessage == lastMessage &&
        other.dateSent == dateSent &&
        other.isAcitvity == isAcitvity &&
        other.isSeen == isSeen;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        lastMessage.hashCode ^
        dateSent.hashCode ^
        isAcitvity.hashCode ^
        isSeen.hashCode;
  }

  LastMessage copyWith({
    String? senderId,
    String? lastMessage,
    DateTime? dateSent,
    bool? isAcitvity,
    bool? isSeen,
  }) {
    return LastMessage(
      senderId: senderId ?? this.senderId,
      lastMessage: lastMessage ?? this.lastMessage,
      dateSent: dateSent ?? this.dateSent,
      isAcitvity: isAcitvity ?? this.isAcitvity,
      isSeen: isSeen ?? this.isSeen,
    );
  }
}
