import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  // Save journal entry to local storage
  static Future<void> saveJournalEntry(String key, String content) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, content);
  }

  // Fetch journal entry from local storage
  static Future<String?> getJournalEntry(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
