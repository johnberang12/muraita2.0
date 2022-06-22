import 'package:flutter/material.dart';

enum TabItem { home, neighborhood, chats, account }

class TabItemData {
  const TabItemData({required this.label, required this.icon});

  final String label;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(label: 'Home', icon: Icons.home),
    TabItem.neighborhood:
        TabItemData(label: 'neighborhood', icon: Icons.deck_rounded),
    TabItem.chats:
        TabItemData(label: 'Chats', icon: Icons.chat_bubble_outline_rounded),
    TabItem.account: TabItemData(
      label: 'Account',
      icon: Icons.person,
    ),
  };
}
