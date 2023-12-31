import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/utils/background_service.dart';
import 'package:news_app/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;

    if (_isScheduled) {
      print('Scheduling news active');

      notifyListeners();

      DateTimeHelper.format();

      // return await AndroidAlarmManager.periodic(
      //   const Duration(seconds: 5), 
      //   1, 
      //   BackgroundService.callback,
      //   startAt: DateTimeHelper.format(),
      //   exact: true,
      //   wakeup: true
      // );

      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24), 
        1, 
        BackgroundService.callback,
        exact: true,
        wakeup: true,
        startAt: DateTime.now()
      );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}