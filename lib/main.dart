import 'package:flutter/material.dart';
import 'package:gratenote_app/app.dart';

import 'utils/service_locator.dart';

void main() {
  setupLocator();
  runApp(const GrateNoteApp());
}
