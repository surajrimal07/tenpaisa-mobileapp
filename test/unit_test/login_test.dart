// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:paisa/feathures/auth/presentation/pages/login_widget.dart';

// void main() {
//   testWidgets('check for button named signin', (tester) async {
//     await tester.pumpWidget(
//         const ProviderScope(child: MaterialApp(home: SigninView())));
//     await tester.pumpAndSettle();
//     var textfield1 = find.byType(TextFormField).at(0);
//     //expect(textfield1, findsOneWidget);
//     await tester.enterText(textfield1, 'suraj@rimal.com');
//     // expect(find.text('Sign In'), findsOneWidget);
//     await tester.enterText(find.byType(TextFormField).at(1), '111111');
//     await tester.tap(find.text('Sign In'));
//     //await tester.pumpAndSettle();

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });
// }
