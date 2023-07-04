import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/article_list_page.dart';
import 'package:news_app/common/styles.dart';
import 'package:news_app/ui/bookmark_page.dart';
import 'package:news_app/ui/detail_page.dart';
import 'package:news_app/ui/setting_page.dart';
import 'package:news_app/utils/notification_helper.dart';
import 'package:news_app/widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex=  0;
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(ArticleDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  final List<BottomNavigationBarItem> _bottomNavBaritems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: 'Headline'
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.bookmark : Icons.collections_bookmark),
      label: 'Bookmark'
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: 'Setting'
    ),
  ];

  final List<Widget> _listWidget = [
    const ArticleListPage(),
    const BookmarksPage(),
    const SettingPage(),
  ];

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBaritems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      // body: ArticleListPage(),
      tabBar: CupertinoTabBar(
        activeColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBaritems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos)
    );
  }
}