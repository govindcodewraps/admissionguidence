
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebviewScreen extends StatefulWidget {
  String url;
  String page_name;

  CommonWebviewScreen({Key? key, this.url = "", this.page_name = ""})
      : super(key: key);

  @override
  _CommonWebviewScreenState createState() => _CommonWebviewScreenState();
}

class _CommonWebviewScreenState extends State<CommonWebviewScreen> {
  late WebViewController _webViewController;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    webView();
  }

  webView() {
    _webViewController = WebViewController();

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {},
          onPageFinished: (page) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: _isLoading ? buildLoadingIndicator() : buildBody(),
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBody() {
    return SizedBox.expand(
      child: Container(
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(CupertinoIcons.arrow_left, color:Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "${widget.page_name}",
        style: TextStyle(fontSize: 16, color:Colors.black),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
