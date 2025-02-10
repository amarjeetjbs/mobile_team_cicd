import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_team_cicd/feature/login/login_page.dart';

void main() {
  testWidgets(
    'MyWidget has a title and message',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginPage(),
        ),
      );

      final titleFinder = find.text('Login');
      expect(titleFinder, findsAtLeast(2));

      final loginBtnFinder = find.byKey(const ValueKey("LoginBtn"));
      expect(loginBtnFinder, findsOneWidget);

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);

      final emailFieldFinder = find.byKey(const ValueKey("emailField"));
      final passwordFieldFinder = find.byKey(const ValueKey("passwordField"));

      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);

      await tester.enterText(emailFieldFinder, "amar@gmail.com");
      await tester.enterText(passwordFieldFinder, "amarjeet");

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.text('Check your email'), findsNothing);
      expect(find.text('Password must be length 8 letter/digit'), findsNothing);


    },
  );
}
