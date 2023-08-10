import 'package:get_it/get_it.dart';
import 'journal_entry_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => JournalEntryService());
}
