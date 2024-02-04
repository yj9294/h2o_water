
import 'dart:convert';

import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheUtil {
  static final _shared = CacheUtil._internal();
  CacheUtil._internal();
  factory CacheUtil() => _shared;

  Future<List<RecordModel>> getRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStrs = prefs.getStringList("record.list");
    if (jsonStrs != null) {
      final records = jsonStrs.map((e) => RecordModel.fromJson(jsonDecode(e))).toList();
      return records;
    }
    return [];
  }

  appendRecord(RecordModel record) async {
    final prefs = await SharedPreferences.getInstance();
    final records = await getRecords();
    records.add(record);

    final jsonStrs = records.map((e) => jsonEncode(e)).toList();
    prefs.setStringList("record.list", jsonStrs);
  }

  Future<int> getGoal() async {
    final prefs = await SharedPreferences.getInstance();
    final goal = prefs.getInt("goal") ?? 2000;
    return goal == 0 ? 2000 : goal;
  }
  updateGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("goal", goal);
  }

  Future<List<String>> getReminders() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> def = ["08:00", "10:00", "12:00", "14:00", "16:00", "18:00", "20:00"];
    final items = prefs.getStringList("reminders") ?? def;
    return items.isEmpty ? def : items;
  }

  void appendReminder(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getReminders();
    if (items.contains(item)) {
      return;
    }
    items.add(item);
    items.sort((a, b) => a.compareTo(b));
    prefs.setStringList("reminders", items);
  }

  void removereminder(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getReminders();
    if (items.contains(item)) {
      items.removeWhere((element) => element == item);
    }
    prefs.setStringList("reminders", items);
  }

  Future<bool> getWeekMode() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getBool("week.mode") ?? false;
    return mode;
  }

  updateWeekMode(bool mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("week.mode", mode);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString("language") ?? "english";
    return language;
  }

  updateLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("language", language);
  }
}