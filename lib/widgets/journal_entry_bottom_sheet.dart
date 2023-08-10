import 'package:flutter/material.dart';

import '../utils/journal_entry_service.dart';
import '../utils/service_locator.dart';

class JournalEntryBottomSheet extends StatefulWidget {
  final DateTime date;
  final TextEditingController controller;

  const JournalEntryBottomSheet(
      {super.key, required this.date, required this.controller});

  @override
  State<JournalEntryBottomSheet> createState() =>
      _JournalEntryBottomSheetState();
}

class _JournalEntryBottomSheetState extends State<JournalEntryBottomSheet> {
  final journalService = locator<JournalEntryService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              height: 5.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          Text(
            'Journal Entry for ${widget.date.month}-${widget.date.day}',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: widget.controller,
            maxLines: 5,
            maxLength: 100,
            decoration: InputDecoration(
              labelText: 'What are you grateful for today?',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Save the journal entry
                  await journalService.saveJournalEntry(
                      widget.date, widget.controller.text);

                  // Dismiss the bottom sheet
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
