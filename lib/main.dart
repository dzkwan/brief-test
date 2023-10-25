import 'package:brieftest/view/login_screen.dart';
import 'package:brieftest/view/widget/auth.dart';
import 'package:brieftest/viewmodel/post_viewmodel.dart';
import 'package:brieftest/viewmodel/tabbar_viewmodel.dart';
import 'package:brieftest/viewmodel/deteksi_viewmodel.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabbarViewModel()),
        ChangeNotifierProvider(create: (_) => DeteksiViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: Auth(),
      ),
    );
  }
}
