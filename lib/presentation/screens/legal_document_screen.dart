import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

/// Public markdown page (privacy, terms, deletion, community guidelines).
class LegalDocumentScreen extends StatefulWidget {
  const LegalDocumentScreen({super.key, required this.assetPath});

  final String assetPath;

  @override
  State<LegalDocumentScreen> createState() => _LegalDocumentScreenState();
}

class _LegalDocumentScreenState extends State<LegalDocumentScreen> {
  final ScrollController _scrollController = ScrollController();
  late final Future<String> _document;

  @override
  void initState() {
    super.initState();
    _document = rootBundle.loadString(widget.assetPath);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _document,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load this page.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
          return Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: MarkdownWidget(
                data: snapshot.data ?? '',
                shrinkWrap: true,
                selectable: true,
                padding: const EdgeInsets.all(16),
              ),
            ),
          );
        },
      ),
    );
  }
}
