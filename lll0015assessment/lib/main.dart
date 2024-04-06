import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
            //image: AssetImage("assets/imgs/welcome_background.jpg"),
            image: AssetImage("assets/imgs/welcome_background.jpg"),
            fit: BoxFit.cover, // 这将确保图片覆盖整个屏幕
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '欢迎使用梦话监听器',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // 根据你的背景图片，你可能需要更改文字颜色
                ),
              ),
              const SizedBox(height: 20), // 用于在文本和按钮之间添加一些空间
              ElevatedButton(
                onPressed: () {
                  // 在这里添加按钮点击事件，如导航到应用的下一个页面
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
