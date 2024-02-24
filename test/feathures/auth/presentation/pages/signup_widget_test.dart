import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paisa/feathures/auth/presentation/pages/signup_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

void main() {
  testWidgets('Check if name field is present', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byKey(const Key('username_field')), findsOneWidget);
  });

  testWidgets('Check if phone field is present', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byKey(const Key('phone_field')), findsOneWidget);
  });

  testWidgets('Check if email field is present', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byKey(const Key('email_field')), findsOneWidget);
  });

  testWidgets('Check if password field is present',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byKey(const Key('password_field')), findsOneWidget);
  });

  testWidgets('Check if signup button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byKey(const Key('signup_button')), findsOneWidget);
  });

  testWidgets('Check if remember me checkbox is present',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byKey(const Key('remember_me_checkbox')), findsOneWidget);
  });

  testWidgets('Check if social login button is present',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byType(SocialLoginButton), findsOneWidget);
  });

  testWidgets('Check if already account text is present',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byKey(const Key('already_account_text')), findsOneWidget);
  });

  testWidgets('Check if signin text is present', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    expect(find.byKey(const Key('signin_text')), findsOneWidget);
  });

  testWidgets('Check if signin text is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignupView())));
    await tester.tap(find.byKey(const Key('signin_text')));
  });
}
