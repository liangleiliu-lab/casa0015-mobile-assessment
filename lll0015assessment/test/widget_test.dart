
import 'package:flutter_test/flutter_test.dart';

import 'package:lll0015assessment/main.dart'; // 确保这个路径匹配你的项目结构

void main() {
  testWidgets('Welcome screen test', (WidgetTester tester) async {
    // 构建我们的应用并触发一帧。
    await tester.pumpWidget(const MyApp());

    // 验证“欢迎使用梦话监听器”文本是否存在。
    expect(find.text('欢迎使用梦话监听器'), findsOneWidget);

    // 验证“开始”按钮是否存在。
    expect(find.text('开始'), findsOneWidget);

    // （可选）如果你的按钮点击后会导航到新的页面或有其他交互，可以在这里继续编写测试代码来模拟和验证那些行为。
    // 例如，如果点击“开始”按钮会导航到一个新页面，并显示新的文本，则可以这样测试：
    // await tester.tap(find.text('开始'));
    // await tester.pumpAndSettle(); // 等待动画完成
    // expect(find.text('新页面文本'), findsOneWidget);
  });
}
