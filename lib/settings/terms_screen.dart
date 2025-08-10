import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermOfServicePage extends StatefulWidget {
  const TermOfServicePage({Key? key}) : super(key: key);

  @override
  State<TermOfServicePage> createState() => _TermOfServicePageState();
}

class _TermOfServicePageState extends State<TermOfServicePage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://sites.google.com/view/lisatermofuse/home'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms Of Use'), backgroundColor: Colors.black54),
      body: WebViewWidget(controller: _controller),
    );
  }
}
