import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lll0015assessment/provider/recorder.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import 'pages/recording.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  //await container.read(recoderProvider).init();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgs/welcome_background.jpg"),
            fit: BoxFit.cover, 
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DigitalClock(
                digitAnimationStyle: Curves.easeIn,
                is24HourTimeFormat: false,
                areaDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                hourMinuteDigitTextStyle: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
                amPmDigitTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '欢迎使用梦话监听器',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecordPage()),
                  );
                },
                child: const Text('开始'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}