// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatPath {
  ChatPath({
    required this.productId,
    required this.sellerId,
    required this.senderId,
    required this.lastMessage,
  });

  final String productId;
  final String sellerId;
  final String senderId;
  final String lastMessage;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'sellerId': sellerId,
      'senderId': senderId,
      'lastMessage': lastMessage,
    };
  }

  factory ChatPath.fromMap(Map<String, dynamic> map, String documentId) {
    return ChatPath(
      productId: map['productId'] as String,
      sellerId: map['sellerId'] as String,
      senderId: map['senderId'] as String,
      lastMessage: map['lastMessage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ChatPath(productId: $productId, sellerId: $sellerId, senderId: $senderId, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(covariant ChatPath other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.sellerId == sellerId &&
        other.senderId == senderId &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        sellerId.hashCode ^
        senderId.hashCode ^
        lastMessage.hashCode;
  }

  ChatPath copyWith({
    String? productId,
    String? sellerId,
    String? senderId,
    String? lastMessage,
  }) {
    return ChatPath(
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      senderId: senderId ?? this.senderId,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
