import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muitsu_arked/games/rps_game/rps_game_utils.dart';
import 'package:muitsu_arked/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ])
      .then((value) =>
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive))
      .then((value) => runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(create: ((context) => RpsGameUtils()))
            ],
            child: const MyApp(),
          )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My arked',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage());
  }
}
