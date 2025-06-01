import 'package:flutter/material.dart';
import 'package:sccc_v3/app.dart';
import 'package:sccc_v3/core/database/database.dart';
import 'package:sccc_v3/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize any necessary services or plugins here
  setupServiceLocator(); // if you are registering plugins inside service locator this should be called first
  final db = getIt<AppDatabase>();
  // await db.deleteDatabaseFile();
  await db.printAllTables(); // Optional: Print all local users for debugging

  runApp(SCCCApp());
}
