import 'package:time_tracker_flutter_app/app/model/settings_model.dart';
import 'package:time_tracker_flutter_app/services/auth.dart';

class MenuItem{

   List<SettingsMenuItem> item =[
    profile,
    govet_schemes,
    BJP_feed,
    third_party_feed,
    log_out,
  ];

  static const profile = SettingsMenuItem (
    text: 'Profile',
  );
   static const govet_schemes = SettingsMenuItem (
    text: 'Govt Schemes',
  );
   static const BJP_feed = SettingsMenuItem (
    text: 'BJP Gujarat Feed',
  );
   static const third_party_feed = SettingsMenuItem (
    text: '3rd party pages feed',
  );
   static const log_out = SettingsMenuItem (
    text: 'Log out',
  );

}