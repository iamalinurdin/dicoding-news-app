import 'dart:io';

import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/preferences_provider.dart';
import 'package:news_app/provider/scheduling_provider.dart';
import 'package:news_app/widgets/custom_dialog.dart';
import 'package:news_app/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme, 
                  onChanged: (value) {
                    provider.enabledDarkTheme(value);
                  }
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Scheduling News'),
                // trailing: Switch.adaptive(
                //   value: false, 
                //   onChanged: (value) => customDialog(context)
                // ),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyNewsActive, 
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledNews(value);
                          provider.enabledDailyNews(value);
                        }
                      }
                    );
                  },
                ),
              ),
            )
          ],
        );
      } 
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const  CupertinoNavigationBar(
        middle: Text('Setting'),
      ),
      child: _buildList(context),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SchedulingProvider(),
      child: PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos)
    );
    // return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

}