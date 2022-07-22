// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../authentication/domain/app_user.dart';
import 'chat.dart';

class ChatModel {
  ChatModel({
    required this.uid,
    required this.userId,
    required this.activity,
    required this.group,
    required this.members,
    required this.messages,
  }) {
    recepients = members.where((i) => i.uid != userId).toList();
  }
  final String uid;
  final String userId;
  final bool activity;
  final bool group;
  final List<AppUser> members;
  List<Chat> messages;
  late final List<AppUser> recepients;

  List<AppUser> chatRecepients() {
    return recepients;
  }

  String? title() {
    return !group
        ? recepients.first.displayName
        : recepients.map((user) => user.displayName).join(', ');
  }

  // String imageUrl() {
  //   return !group ? recepients.first.displayName : '';
  // }
}
