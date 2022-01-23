import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/view/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}