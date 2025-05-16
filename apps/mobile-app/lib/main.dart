import 'package:almabike_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getApplicationDocumentsDirectory();
  await GetStorage.init();
  runApp(const AlmabikeApp());
}
