import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// WebViewページ
class WebViewPage extends StatelessWidget {
  /// コンストラクタ
  const WebViewPage({
    super.key,
    required this.url,
  });

  /// URL
  final String url;

  @override
  Widget build(BuildContext context) {
    final uri = WebUri(url);
    return Container(
      height: MediaQuery.of(context).size.height * 0.9, // ボトムシートの高さ
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: uri),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
      ),
    );
  }
}
