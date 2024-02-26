import 'package:flutter/material.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String name;

  const WebViewPage({super.key, required this.url, required this.name});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.isDarkMode(context)
          ? AppColors.greyPrimaryColor
          : AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 32,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 18,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.name, style: const TextStyle(fontSize: 16)),
      ),
      body: Stack(
        children: [
          WebView(
            gestureNavigationEnabled: true,
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (progress) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (progress) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) => Center(
              child: Text('Error: ${error.description}'),
            ),
          ),
          if (_isLoading)
            const Center(
                child: LoadingIndicatorWidget(
              size: 50,
              showText: false,
              text: 'Loading...',
            )),
        ],
      ),
    );
  }
}
