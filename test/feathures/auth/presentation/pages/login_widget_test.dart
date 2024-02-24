import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paisa/feathures/auth/presentation/pages/login_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

void main() {
  testWidgets('check for button named signin', (tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SigninView())));
    await tester.pumpAndSettle();
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Renders email and password text fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SigninView())));

    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('Renders remember me checkbox', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SigninView())));

    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('Renders social login button', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SigninView())));

    expect(find.byType(SocialLoginButton), findsOneWidget);
  });
  testWidgets('Renders signup text', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SigninView())));

    expect(find.text(' Sign Up'), findsOneWidget);
  });

  //this test should fail
  testWidgets('Renders skip text', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SigninView())));

    expect(find.text(' Skip'), findsOneWidget);
  });
}
