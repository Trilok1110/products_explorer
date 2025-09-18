import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Mode { future, stream }

class ModeProvider extends ChangeNotifier {
  Mode mode = Mode.future;

  ModeProvider() {
    _loadMode();
  }

  Future<void> _loadMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString('mode');
    if (savedMode == 'stream') {
      mode = Mode.stream;
    } else {
      mode = Mode.future;
    }
    notifyListeners();
  }

  Future<void> setMode(Mode newMode) async {
    mode = newMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mode', newMode.name);
    notifyListeners();
  }
}