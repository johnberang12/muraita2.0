// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

///change date to dateSent
///
enum MessageType { text, image, unknown }

class Chat {
  Chat({
    required this.id,
    required this.content,
    required this.sentTime,
    required this.type,
    required this.senderId,
    required this.sellerId,
  });
  final String id;
  final String content;
  final DateTime sentTime;
  final MessageType type;
  final String senderId;
  final String sellerId;

  Map<String, dynamic> toMap() {
    String messageType;
    switch (type) {
      case MessageType.text:
        messageType = 'text';
        break;
      case MessageType.image:
        messageType = 'image';
        break;
      default:
        messageType = '';
    }

    return <String, dynamic>{
      'id': id,
      'content': content,
      'sentTime': Timestamp.fromDate(sentTime),
      'type': messageType,
      'senderId': senderId,
      'sellerId': sellerId,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map, String documentId) {
    MessageType messageType;
    switch (map['type']) {
      case 'text':
        messageType = MessageType.text;
        break;
      case 'image':
        messageType = MessageType.image;
        break;
      default:
        messageType = MessageType.unknown;
    }
    return Chat(
      id: map['id'] as String,
      content: map['content'] as String,
      sentTime: (map['sentTime'] as Timestamp).toDate(),
      type: messageType,
      senderId: map['senderId'] as String,
      sellerId: map['sellerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Chat.fromJson(String source) =>
  //     Chat.fromMap(json.decode(source) as Map<String, dynamic>, );

  @override
  String toString() {
    return 'Chat(id: $id, content: $content, sentTime: $sentTime, type: $type, senderId: $senderId, sellerId: $sellerId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.id == id &&
        other.content == content &&
        other.sentTime == sentTime &&
        other.type == type &&
        other.senderId == senderId &&
        other.sellerId == sellerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        content.hashCode ^
        sentTime.hashCode ^
        type.hashCode ^
        senderId.hashCode ^
        sellerId.hashCode;
  }

  Chat copyWith({
    String? id,
    String? content,
    DateTime? sentTime,
    MessageType? type,
    String? senderId,
    String? sellerId,
  }) {
    return Chat(
      id: id ?? this.id,
      content: content ?? this.content,
      sentTime: sentTime ?? this.sentTime,
      type: type ?? this.type,
      senderId: senderId ?? this.senderId,
      sellerId: sellerId ?? this.sellerId,
    );
  }
}
