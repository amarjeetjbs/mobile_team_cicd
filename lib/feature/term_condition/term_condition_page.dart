import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermAndConditionPage extends StatefulWidget {
  const TermAndConditionPage({super.key});

  @override
  State<TermAndConditionPage> createState() => _TermAndConditionPageState();
}

class _TermAndConditionPageState extends State<TermAndConditionPage> {
  Future<String> loadTerms() async {
    return await rootBundle.loadString('assets/term_and_condition.md');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: FutureBuilder<String>(
        future: loadTerms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading terms.'));
          }
          return Markdown(
            data: snapshot.data ?? '',
            styleSheet: MarkdownStyleSheet.fromTheme(
              Theme.of(context),
            ),
          );
        },
      ),
    );
  }
}
