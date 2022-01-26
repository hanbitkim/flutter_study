import 'package:artitecture/src/firebase_initializer.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/view/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await initializeFirebase();
  runApp(const MyApp());
}