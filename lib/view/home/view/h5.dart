import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class H5 extends StatefulWidget {
  final String h5;
  const H5({super.key, required this.h5});

  @override
  State<H5> createState() => _H5State();
}

class _H5State extends State<H5> {
  final GlobalKey webViewKey = GlobalKey();
  bool isLoading = true;
  String h5 = "https://m.citifutures.cc/";
  final List<ContentBlocker> contentBlockers = [];
  var contentBlockerEnabled = true;

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );
  @override
  void initState() {
    super.initState();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: pullToRefreshSettings,
            onRefresh: () async {
              if (Platform.isAndroid) {
                webViewController?.reload();
              } else if (Platform.isIOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        if (await webViewController!.canGoBack()) {
          webViewController!.goBack();
        }
      },
      child: Scaffold(
          backgroundColor: const Color(0xff20222c),
          body: SafeArea(
            child: InAppWebView(
              key: webViewKey,
              gestureRecognizers: Set()
                ..add(Factory<HorizontalDragGestureRecognizer>(() {
                  return HorizontalDragGestureRecognizer()
                    ..onUpdate = (_) {
                      Navigator.pop(context);
                    };
                })),
              initialUrlRequest: URLRequest(url: WebUri(widget.h5)),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!.toString();
                if (uri.toString().contains("t.me") ||
                    uri.toString().contains("whatsapp") ||
                    uri.toString().contains("line")) {
                  if (!await launchUrl(Uri.parse(uri.toString()),
                      mode: LaunchMode.externalApplication)) {
                    return NavigationActionPolicy.CANCEL;
                  }
                }
                return NavigationActionPolicy.ALLOW;
              },
              initialSettings: InAppWebViewSettings(
                supportZoom: false,
                javaScriptCanOpenWindowsAutomatically: true,
                transparentBackground: true,
                supportMultipleWindows: true,
                allowsBackForwardNavigationGestures: true,
              ),
              // pullToRefreshController: pullToRefreshController,
              onLoadStop: (controller, url) {
                // pullToRefreshController?.endRefreshing();
              },
              onReceivedError: (controller, request, error) {
                // pullToRefreshController?.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  // pullToRefreshController?.endRefreshing();
                }
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
            ),
          )),
    );
  }
}
