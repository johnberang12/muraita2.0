import 'package:flutter/cupertino.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';
import 'package:muraita_2_0/src/routing/bottom_navigation_bar/tab_item.dart';

import '../../constants/app_sizes.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectedTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.home),
          _buildItem(TabItem.neighborhood),
          _buildItem(TabItem.chats),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item]!(context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? kPrimaryHue : kBlack20;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData!.icon,
        color: color,
        size: Sizes.p24,
      ),
      label: itemData.label,
    );
  }
}
