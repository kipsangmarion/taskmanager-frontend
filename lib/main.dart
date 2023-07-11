import 'dart:async';

import 'package:flutter/material.dart';


import 'di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
}
