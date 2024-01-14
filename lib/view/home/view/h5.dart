import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class H5 extends StatefulWidget {
  const H5({super.key});

  @override
  State<H5> createState() => _H5State();
}

class _H5State extends State<H5> {
  final GlobalKey webViewKey = GlobalKey();
  bool isLoading = true;

  final List<ContentBlocker> contentBlockers = [];
  var contentBlockerEnabled = true;

  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: SafeArea(
              child: Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest:
                  URLRequest(url: WebUri('https://m.citifutures.cc/')),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
            ),
          ],
        ),
      ))),
    );
  }
}
