import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeNewView extends StatefulWidget {
  const HomeNewView({super.key});

  @override
  State<HomeNewView> createState() => _HomeNewViewState();
}

class _HomeNewViewState extends State<HomeNewView> {
  final GlobalKey webViewKey = GlobalKey();
  bool isLoading = true;

  // list of Ad URL filters to be used to block ads loading.
  final adUrlFilters = [
    ".*.doubleclick.net/.*",
    ".*.ads.pubmatic.com/.*",
    ".*.googlesyndication.com/.*",
    ".*.google-analytics.com/.*",
    ".*.adservice.google.*/.*",
    ".*.adbrite.com/.*",
    ".*.exponential.com/.*",
    ".*.quantserve.com/.*",
    ".*.scorecardresearch.com/.*",
    ".*.zedo.com/.*",
    ".*.adsafeprotected.com/.*",
    ".*.teads.tv/.*",
    ".*.outbrain.com/.*"
  ];

  final List<ContentBlocker> contentBlockers = [];
  var contentBlockerEnabled = true;

  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    for (final adUrlFilter in adUrlFilters) {
      contentBlockers.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }

    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              setState(() async {
                if (await webViewController!.canGoBack()) {
                  webViewController!.goBack();
                }
              });
            },
          ),
          body: SafeArea(
              child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 18.0),
            margin: const EdgeInsets.only(top: 18.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                InAppWebView(
                  key: webViewKey,
                  initialUrlRequest:
                      URLRequest(url: WebUri('https://cryptonews.net/')),
                  initialSettings: InAppWebViewSettings(
                      contentBlockers: contentBlockers),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                   },
                  onLoadStart: (controller, url) {
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onLoadStop: (controller, url) async {
                    setState(() {
                      webViewController!.evaluateJavascript(
                          source: """
                          window.addEventListener('DOMContentLoaded', function(event) { 
                            \$('header').remove();
                            \$('.download_the_app').remove();
                            \$('footer').remove();
                            \$('.footer').remove();
                            \$('.vert').remove(); 
                            \$('noindex').remove();     
                            \$('.article-source-link').remove();       
                            \$('#top-coins').remove();        
                            \$('.top-coins-title').remove();       
                            \$('.info').remove();   
                            \$('.cookies_processing').remove();
                             \$('div').removeAttr('ng-include')
                            \$('div').removeAttr('ng-if')

                          });
                          """);
                      isLoading = false;
                
                    });
                  }, 
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    final uri = navigationAction.request.url!;
                    if (uri.toString().contains('cryptonews.net')) {
                      return NavigationActionPolicy.ALLOW;
                    }
                    return NavigationActionPolicy.CANCEL;
                  },
                  initialUserScripts: UnmodifiableListView([
                    UserScript(
                        source: """
                  window.addEventListener('DOMContentLoaded', function(event) { 
                    \$('header').remove();
                    \$('.download_the_app').remove();
                    \$('footer').remove();
                    \$('.footer').remove();
                    \$('.vert').remove(); 
                    \$('noindex').remove();     
                    \$('.article-source-link').remove();       
                    \$('#top-coins').remove();        
                    \$('.top-coins-title').remove();       
                    \$('.info').remove();   
                    \$('.cookies_processing').remove();
                  \$('div').removeAttr('ng-include')
                            \$('div').removeAttr('ng-if')
                  });
                  """,
                        injectionTime:
                            UserScriptInjectionTime.AT_DOCUMENT_START)
                  ]),
                ),
                if (isLoading)
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),),
                )
              ],
            ),
          ))),
    );
  }
}
