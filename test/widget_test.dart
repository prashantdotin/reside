import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/main.dart';

void main() {
  testWidgets('renders manager dashboard', (tester) async {
    await tester.pumpWidget(const ResideApp());
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Teams'), findsOneWidget);
    expect(find.text('VIEW TEAM PERFORMANCE'), findsOneWidget);
  });
}
