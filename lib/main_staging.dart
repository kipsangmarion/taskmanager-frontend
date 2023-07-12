import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskmanager_frontend/app/app.dart';
import 'package:taskmanager_frontend/bootstrap.dart';

import 'di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  unawaited(bootstrap(() => const App()));
}