import 'package:flutter/material.dart';
import 'package:gratenote_app/widgets/grate_calendar.dart';

import '../models/journal_entry.dart';
import '../utils/journal_entry_service.dart';
import '../utils/service_locator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  final journalService = locator<JournalEntryService>();

  @override
  void initState() {
    super.initState();
    _fetchTodayEntry();
  }

  _fetchTodayEntry() async {
    DateTime today = DateTime.now();
    JournalEntry? entry = await journalService.getJournalEntry(today);
    _controller.text = entry?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GrateNote'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'Calendar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTodayTab(),
            GrateCalendar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            maxLines: 5,
            maxLength: 100,
            decoration: const InputDecoration(
              labelText: 'What are you grateful for today?',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await journalService.saveJournalEntry(
                  DateTime.now(), _controller.text);
              // Optionally, add feedback to the user to indicate the entry has been saved.
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
