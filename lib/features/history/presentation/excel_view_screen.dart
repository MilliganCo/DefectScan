// lib/features/history/presentation/excel_view_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExcelViewScreen extends StatelessWidget {
  const ExcelViewScreen({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(
                'https://view.officeapps.live.com/op/embed.aspx?src=$url')),
        ),
      );
}
// // The `ExcelViewScreen` widget is a stateless widget that displays a web view of an Excel file.
// // It takes a URL as a parameter and uses the `WebViewWidget` to load the Excel file using the Office Web Viewer.