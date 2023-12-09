import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_christ_song/widgets/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const App());
}
