import 'package:flutter/material.dart';

import '../models/journal_entry.dart';
import '../utils/journal_entry_service.dart';
import '../utils/service_locator.dart';
import 'journal_entry_bottom_sheet.dart';

class GrateCalendar extends StatefulWidget {
  const GrateCalendar({super.key});

  @override
  State<GrateCalendar> createState() => _GrateCalendarState();
}

class _GrateCalendarState extends State<GrateCalendar> {
  DateTime currentDate = DateTime.now();
  List<DateTime> get datesInMonth {
    var lastDay = DateTime(currentDate.year, currentDate.month + 1, 0);
    return List<DateTime>.generate(lastDay.day,
        (i) => DateTime(currentDate.year, currentDate.month, i + 1));
  }

  final journalService = locator<JournalEntryService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  currentDate =
                      DateTime(currentDate.year, currentDate.month - 1, 1);
                });
              },
            ),
            Text(
              "${currentDate.month}-${currentDate.year}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  currentDate =
                      DateTime(currentDate.year, currentDate.month + 1, 1);
                });
              },
            ),
          ],
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7),
            itemCount: datesInMonth.length,
            itemBuilder: (context, index) {
              return FutureBuilder<bool>(
                future: journalService.hasEntry(datesInMonth[index]),
                builder: (context, snapshot) {
                  bool hasEntry = snapshot.data ?? false;

                  return GestureDetector(
                    onTap: () async {
                      JournalEntry? entry = await journalService
                          .getJournalEntry(datesInMonth[index]);
                      TextEditingController controller =
                          TextEditingController(text: entry?.content ?? '');
                      // ignore: use_build_context_synchronously
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // This allows for smaller bottom sheets
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: JournalEntryBottomSheet(
                                date: datesInMonth[index],
                                controller: controller),
                          ),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: hasEntry
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${datesInMonth[index].day}',
                        style: TextStyle(
                          color:
                              hasEntry ? Theme.of(context).primaryColor : null,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
