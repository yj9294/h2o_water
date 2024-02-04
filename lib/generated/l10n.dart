// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Daily Goal {goal}ml`
  String daily_goal_title(Object goal) {
    return Intl.message(
      'Daily Goal ${goal}ml',
      name: 'daily_goal_title',
      desc: '',
      args: [goal],
    );
  }

  /// `Add To`
  String get add_to {
    return Intl.message(
      'Add To',
      name: 'add_to',
      desc: '',
      args: [],
    );
  }

  /// `Drinking water setting`
  String get goal_title {
    return Intl.message(
      'Drinking water setting',
      name: 'goal_title',
      desc: '',
      args: [],
    );
  }

  /// `Drinking water setting`
  String get record_title {
    return Intl.message(
      'Drinking water setting',
      name: 'record_title',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get water {
    return Intl.message(
      'Water',
      name: 'water',
      desc: '',
      args: [],
    );
  }

  /// `Coffee`
  String get coffee {
    return Intl.message(
      'Coffee',
      name: 'coffee',
      desc: '',
      args: [],
    );
  }

  /// `Drinks`
  String get drinks {
    return Intl.message(
      'Drinks',
      name: 'drinks',
      desc: '',
      args: [],
    );
  }

  /// `Tea`
  String get tea {
    return Intl.message(
      'Tea',
      name: 'tea',
      desc: '',
      args: [],
    );
  }

  /// `Milk`
  String get milk {
    return Intl.message(
      'Milk',
      name: 'milk',
      desc: '',
      args: [],
    );
  }

  /// `Customization`
  String get customization {
    return Intl.message(
      'Customization',
      name: 'customization',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Historical record`
  String get history_title {
    return Intl.message(
      'Historical record',
      name: 'history_title',
      desc: '',
      args: [],
    );
  }

  /// `Archievement Medal`
  String get medal_title {
    return Intl.message(
      'Archievement Medal',
      name: 'medal_title',
      desc: '',
      args: [],
    );
  }

  /// `Keep drinking water`
  String get keep_title {
    return Intl.message(
      'Keep drinking water',
      name: 'keep_title',
      desc: '',
      args: [],
    );
  }

  /// `Drinking Water Archievement`
  String get arch_title {
    return Intl.message(
      'Drinking Water Archievement',
      name: 'arch_title',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get profile_title {
    return Intl.message(
      'Setting',
      name: 'profile_title',
      desc: '',
      args: [],
    );
  }

  /// `Reminder Time`
  String get reminder {
    return Intl.message(
      'Reminder Time',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us`
  String get rate {
    return Intl.message(
      'Rate Us',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Maintain water balance and focus on your body''s needs`
  String get tip_how {
    return Intl.message(
      'Maintain water balance and focus on your body\'\'s needs',
      name: 'tip_how',
      desc: '',
      args: [],
    );
  }

  /// `Drink water in stages to form a good habit`
  String get tip_better {
    return Intl.message(
      'Drink water in stages to form a good habit',
      name: 'tip_better',
      desc: '',
      args: [],
    );
  }

  /// `Prefer sugar-free drinks and cut down on sugary drinks`
  String get tip_when {
    return Intl.message(
      'Prefer sugar-free drinks and cut down on sugary drinks',
      name: 'tip_when',
      desc: '',
      args: [],
    );
  }

  /// `In daily life, maintaining a good water balance is essential for maintaining good health. Water is a basic component of the human body and plays a vital role in various physiological functions and metabolic processes. Therefore, paying attention to the body's water needs and maintaining a proper water balance is a part of our daily health management that cannot be ignored.\n\nFirst, water is essential for the proper functioning of the body. It is involved in many physiological processes such as blood circulation, digestion and absorption, and temperature regulation. Adequate water can maintain blood dilution, improve blood flow, and thus help the delivery of nutrients to all parts of the body. In addition, moisture also helps to maintain skin elasticity, promote metabolism, and maintain good physical condition.\n\nSecond, paying attention to your body's water needs helps maintain your electrolyte balance. The loss of water is accompanied by an imbalance of electrolytes, which are essential for functions such as nerve transmission and muscle contraction. Therefore, proper water intake can help us avoid electrolyte disorders and maintain the normal work of various systems in the body.\n\nIn addition, our water needs will vary with different seasons and intensity of activity. Your body is more likely to lose water in hot weather or during intense exercise, so you need to increase your water intake to prevent dehydration. Timely adjustment of water intake, focusing on the actual needs of the body, is the key to maintaining water balance.\n\nAll in all, keeping water balance is one of the foundations of maintaining good health. We should always pay attention to the water needs of the body to ensure proper water intake, so as to promote the normal function of the body and maintain good health. By drinking water properly, we can create a healthier and more energetic life.`
  String get tip_how_descrip {
    return Intl.message(
      'In daily life, maintaining a good water balance is essential for maintaining good health. Water is a basic component of the human body and plays a vital role in various physiological functions and metabolic processes. Therefore, paying attention to the body\'s water needs and maintaining a proper water balance is a part of our daily health management that cannot be ignored.\n\nFirst, water is essential for the proper functioning of the body. It is involved in many physiological processes such as blood circulation, digestion and absorption, and temperature regulation. Adequate water can maintain blood dilution, improve blood flow, and thus help the delivery of nutrients to all parts of the body. In addition, moisture also helps to maintain skin elasticity, promote metabolism, and maintain good physical condition.\n\nSecond, paying attention to your body\'s water needs helps maintain your electrolyte balance. The loss of water is accompanied by an imbalance of electrolytes, which are essential for functions such as nerve transmission and muscle contraction. Therefore, proper water intake can help us avoid electrolyte disorders and maintain the normal work of various systems in the body.\n\nIn addition, our water needs will vary with different seasons and intensity of activity. Your body is more likely to lose water in hot weather or during intense exercise, so you need to increase your water intake to prevent dehydration. Timely adjustment of water intake, focusing on the actual needs of the body, is the key to maintaining water balance.\n\nAll in all, keeping water balance is one of the foundations of maintaining good health. We should always pay attention to the water needs of the body to ensure proper water intake, so as to promote the normal function of the body and maintain good health. By drinking water properly, we can create a healthier and more energetic life.',
      name: 'tip_how_descrip',
      desc: '',
      args: [],
    );
  }

  /// `Water is the source of life and is essential for the proper functioning of the body. However, whether we drink water regularly and scientifically is also directly related to the health of the body. Drinking water in stages to form good habits is a lifestyle worthy of praise.\n\nFirst of all, morning is one of the most critical periods of the day. After a full night's sleep, your body is dehydrated. When you wake up in the morning, drinking a cup of warm water in time can help remove metabolites in the body, promote metabolism, and make the body quickly restore vitality. This also helps activate intestinal peristalsis and promotes defecation, which is very beneficial for maintaining a healthy digestive system.\n\nSecondly, daytime is the peak time for activities and work. The right amount of water can help regulate body temperature, prevent dehydration, and keep the body functioning properly. Drinking water in stages between work, study or exercise will not only provide the needed hydration, but also help relieve fatigue and improve concentration and productivity.\n\nFinally, the evening is also a time to pay attention to your water intake. Drinking a glass of water before going to bed can prevent nighttime thirst, while helping to clean the kidneys and promote the body's detoxification function. However, it is important to avoid drinking too much water near bedtime so as not to affect the quality of sleep.\n\nDrinking water in stages not only helps to meet the body's water needs at different times, but also cultivates good drinking habits. Habitually drink water in a specific period of time, so that the body gradually adapt to form a regular lifestyle. Developing a scientific habit of drinking water is not only beneficial to the body but also a manifestation of responsibility for yourself.`
  String get tip_better_descrip {
    return Intl.message(
      'Water is the source of life and is essential for the proper functioning of the body. However, whether we drink water regularly and scientifically is also directly related to the health of the body. Drinking water in stages to form good habits is a lifestyle worthy of praise.\n\nFirst of all, morning is one of the most critical periods of the day. After a full night\'s sleep, your body is dehydrated. When you wake up in the morning, drinking a cup of warm water in time can help remove metabolites in the body, promote metabolism, and make the body quickly restore vitality. This also helps activate intestinal peristalsis and promotes defecation, which is very beneficial for maintaining a healthy digestive system.\n\nSecondly, daytime is the peak time for activities and work. The right amount of water can help regulate body temperature, prevent dehydration, and keep the body functioning properly. Drinking water in stages between work, study or exercise will not only provide the needed hydration, but also help relieve fatigue and improve concentration and productivity.\n\nFinally, the evening is also a time to pay attention to your water intake. Drinking a glass of water before going to bed can prevent nighttime thirst, while helping to clean the kidneys and promote the body\'s detoxification function. However, it is important to avoid drinking too much water near bedtime so as not to affect the quality of sleep.\n\nDrinking water in stages not only helps to meet the body\'s water needs at different times, but also cultivates good drinking habits. Habitually drink water in a specific period of time, so that the body gradually adapt to form a regular lifestyle. Developing a scientific habit of drinking water is not only beneficial to the body but also a manifestation of responsibility for yourself.',
      name: 'tip_better_descrip',
      desc: '',
      args: [],
    );
  }

  /// `Choosing to prefer sugar-free drinks and reducing the intake of sugary drinks is a positive and healthy lifestyle choice. This healthy eating habit not only helps maintain the overall health of the body but also prevents a range of chronic diseases and improves the quality of life.\n\nFirst, cutting down on sugary drinks is essential for weight management. Sugary drinks are often high in calories, and these calories are often "empty calories," which provide calories but have little to no nutritional value. By choosing sugar-free drinks, you can better control your calorie intake and help maintain a healthy weight.\n\nSecondly, reducing sugar intake can help prevent the development of chronic diseases such as diabetes and cardiovascular disease. Excessive sugar consumption is strongly associated with the risk of these diseases. By choosing sugar-free drinks, you can lower blood sugar levels, reduce the burden on the islets, help prevent diabetes, and reduce the chance of cardiovascular disease.\n\nIn addition, reducing the intake of sugary drinks can also help maintain oral health. High sugar drinks can easily lead to tooth decay and periodontal disease. Choosing sugar-free drinks not only doesn't have a harmful effect on your teeth, but it also helps keep your mouth clean.\n\nFinally, the selection of sugar-free drinks is becoming more and more extensive, including a variety of flavors of sugar-free tea, sugar-free coffee, sugar-free beverages and so on. This provides a healthier option for those who prefer a variety of drinks.\n\nOverall, choosing to prefer sugar-free beverages and reducing the intake of sugar-sweetened beverages is an important measure of personal health responsibility. By cultivating good eating habits, we can better protect our bodies and move towards a healthier, more active lifestyle.`
  String get tip_when_descrip {
    return Intl.message(
      'Choosing to prefer sugar-free drinks and reducing the intake of sugary drinks is a positive and healthy lifestyle choice. This healthy eating habit not only helps maintain the overall health of the body but also prevents a range of chronic diseases and improves the quality of life.\n\nFirst, cutting down on sugary drinks is essential for weight management. Sugary drinks are often high in calories, and these calories are often "empty calories," which provide calories but have little to no nutritional value. By choosing sugar-free drinks, you can better control your calorie intake and help maintain a healthy weight.\n\nSecondly, reducing sugar intake can help prevent the development of chronic diseases such as diabetes and cardiovascular disease. Excessive sugar consumption is strongly associated with the risk of these diseases. By choosing sugar-free drinks, you can lower blood sugar levels, reduce the burden on the islets, help prevent diabetes, and reduce the chance of cardiovascular disease.\n\nIn addition, reducing the intake of sugary drinks can also help maintain oral health. High sugar drinks can easily lead to tooth decay and periodontal disease. Choosing sugar-free drinks not only doesn\'t have a harmful effect on your teeth, but it also helps keep your mouth clean.\n\nFinally, the selection of sugar-free drinks is becoming more and more extensive, including a variety of flavors of sugar-free tea, sugar-free coffee, sugar-free beverages and so on. This provides a healthier option for those who prefer a variety of drinks.\n\nOverall, choosing to prefer sugar-free beverages and reducing the intake of sugar-sweetened beverages is an important measure of personal health responsibility. By cultivating good eating habits, we can better protect our bodies and move towards a healthier, more active lifestyle.',
      name: 'tip_when_descrip',
      desc: '',
      args: [],
    );
  }

  /// `Weekend mode`
  String get week_mode {
    return Intl.message(
      'Weekend mode',
      name: 'week_mode',
      desc: '',
      args: [],
    );
  }

  /// `After opening, you won't receive any messages on this.`
  String get week_desc {
    return Intl.message(
      'After opening, you won\'t receive any messages on this.',
      name: 'week_desc',
      desc: '',
      args: [],
    );
  }

  /// `Select time`
  String get time_select {
    return Intl.message(
      'Select time',
      name: 'time_select',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Japanse`
  String get ja {
    return Intl.message(
      'Japanse',
      name: 'ja',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get es {
    return Intl.message(
      'Spanish',
      name: 'es',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get de {
    return Intl.message(
      'German',
      name: 'de',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get ar {
    return Intl.message(
      'Arabic',
      name: 'ar',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get fr {
    return Intl.message(
      'French',
      name: 'fr',
      desc: '',
      args: [],
    );
  }

  /// `Hindi`
  String get hi {
    return Intl.message(
      'Hindi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Portuguese`
  String get pt {
    return Intl.message(
      'Portuguese',
      name: 'pt',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy\nWelcome to the application services provided by H2O Keepper (hereinafter referred to as "we"). We value your privacy and are committed to keeping your personal information safe. This Privacy Policy is intended to explain to you how we collect, use and protect your personal information.\nPlease read this Privacy Policy carefully before using our application services. If you do not agree with any part of this Policy, we recommend that you stop using our Services.\nInformation We collect:\nRegistration Information: When you use the H2O Keepper app, you may be asked to provide some basic information, including but not limited to your name, email address, etc.\nUsage Information: We may collect information about your use of the Application services, including your drinking water records, usage preferences, etc.\nDevice Information: We may automatically collect information about your use of devices and application services, including device model, operating system version, application version, etc.\nUse of information:\nProviding Services: We use the information we collect to provide, maintain and improve the H2O Keepper Application Services to ensure your smooth use.\nPersonalized experience: We may use your information to personalize your experience with the App Services, including providing water alerts and recommendations that better match your preferences.\nStatistical analysis: We may use aggregated, anonymized information for statistical analysis in order to improve our services and understand user habits.\nSharing of information:\nWe promise not to sell, trade or transfer your personal information to third parties, except with your express consent or as required by laws and regulations.\nPrivacy measures:\nWe take a number of security measures to protect your personal information, including but not limited to data encryption, access control, etc. We will do our utmost to ensure the security of your information.\nPrivacy of Minors:\nThe H2O Keepper app service is not intended for children under the age of 13. If you are a minor, you need to use our services under the supervision of a parent or guardian.\nPrivacy Policy Updates:\nWe reserve the right to amend or update this Privacy Policy at any time. We will update our Privacy Policy by in-app notification or by Posting it on our website.\nIf you have any questions or comments about this Privacy Policy, please contact us.\nThank you for choosing H2O Keepper App Service!`
  String get privacy_desc {
    return Intl.message(
      'Privacy Policy\nWelcome to the application services provided by H2O Keepper (hereinafter referred to as "we"). We value your privacy and are committed to keeping your personal information safe. This Privacy Policy is intended to explain to you how we collect, use and protect your personal information.\nPlease read this Privacy Policy carefully before using our application services. If you do not agree with any part of this Policy, we recommend that you stop using our Services.\nInformation We collect:\nRegistration Information: When you use the H2O Keepper app, you may be asked to provide some basic information, including but not limited to your name, email address, etc.\nUsage Information: We may collect information about your use of the Application services, including your drinking water records, usage preferences, etc.\nDevice Information: We may automatically collect information about your use of devices and application services, including device model, operating system version, application version, etc.\nUse of information:\nProviding Services: We use the information we collect to provide, maintain and improve the H2O Keepper Application Services to ensure your smooth use.\nPersonalized experience: We may use your information to personalize your experience with the App Services, including providing water alerts and recommendations that better match your preferences.\nStatistical analysis: We may use aggregated, anonymized information for statistical analysis in order to improve our services and understand user habits.\nSharing of information:\nWe promise not to sell, trade or transfer your personal information to third parties, except with your express consent or as required by laws and regulations.\nPrivacy measures:\nWe take a number of security measures to protect your personal information, including but not limited to data encryption, access control, etc. We will do our utmost to ensure the security of your information.\nPrivacy of Minors:\nThe H2O Keepper app service is not intended for children under the age of 13. If you are a minor, you need to use our services under the supervision of a parent or guardian.\nPrivacy Policy Updates:\nWe reserve the right to amend or update this Privacy Policy at any time. We will update our Privacy Policy by in-app notification or by Posting it on our website.\nIf you have any questions or comments about this Privacy Policy, please contact us.\nThank you for choosing H2O Keepper App Service!',
      name: 'privacy_desc',
      desc: '',
      args: [],
    );
  }

  /// `Tips`
  String get tip {
    return Intl.message(
      'Tips',
      name: 'tip',
      desc: '',
      args: [],
    );
  }

  /// `The body needs energy, don't forget to drink water!`
  String get noti {
    return Intl.message(
      'The body needs energy, don\'t forget to drink water!',
      name: 'noti',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
