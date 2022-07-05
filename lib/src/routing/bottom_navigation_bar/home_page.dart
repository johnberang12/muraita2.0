import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/routing/bottom_navigation_bar/tab_item.dart';
import '../../features/authentication/presentation/account/presentation/account_screen.dart';
import '../../features/chats/presentation/chats_list_screen.dart';
import '../../features/neighbors/neighborhood_screen.dart';

import '../../features/products/presentation/product_screen/product_screen.dart';
import '../../features/products/presentation/products_list/products_list_screen.dart';
import 'cupertino_home_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.neighborhood: GlobalKey<NavigatorState>(),
    TabItem.chats: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => const ProductsListScreen(),
      TabItem.neighborhood: (_) =>  NeighborhoodScreen(),
      TabItem.chats: (_) => const ChatsListScreen(),
      TabItem.account: (_) => const AccountScreen(),
    };
  }

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('entered home page');
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectedTab: _selectTab,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
