import 'package:gratenote_app/models/journal_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalEntryService {
  final Map<String, JournalEntry> _entries = {};

  // Add or update an entry
  Future<void> saveJournalEntry(DateTime date, String content) async {
    final key = _dateToKey(date);
    _entries[key] = JournalEntry(date: date, content: content);

    // Store the entry in shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, content);
  }

  // Get an entry by date
  Future<JournalEntry?> getJournalEntry(DateTime date) async {
    final key = _dateToKey(date);
    if (_entries.containsKey(key)) {
      return _entries[key];
    }

    // If not in memory, try to load from shared preferences
    final prefs = await SharedPreferences.getInstance();
    String? content = prefs.getString(key);
    if (content != null) {
      _entries[key] = JournalEntry(date: date, content: content);
      return _entries[key];
    }

    return null;
  }

  // Check if an entry exists for a particular date
  Future<bool> hasEntry(DateTime date) async {
    final key = _dateToKey(date);
    if (_entries.containsKey(key)) {
      return true;
    }

    // If not in memory, check in shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // Helper function to create a string key from DateTime
  String _dateToKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
