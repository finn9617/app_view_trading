import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Investing extends StatefulWidget {
  const Investing({super.key});

  @override
  State<Investing> createState() => _HomeNewViewState();
}

class _HomeNewViewState extends State<Investing> {
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
                  initialUrlRequest: URLRequest(
                      url: WebUri('https://www.tradingview.com/education/')),
                  initialSettings: InAppWebViewSettings(
                      contentBlockers: contentBlockers,
                      useOnDownloadStart: true),
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
                      webViewController!.evaluateJavascript(source: """
                  window.addEventListener('DOMContentLoaded', function(event) { 
                    \$('.tv-header__top').remove(); 
                    \$('.tv-category-header__content').remove();
                    \$('footer').remove();
                    \$('.footer').remove(); 
                    \$('.tv-social-row__end').remove();  
                    \$('.tv-social-row__start').remove();  
                    \$('.tv-social-row__end--adjusted').remove();  
                    \$('.tv-feed-widget--freeze-margin').remove(); 
                    \$('.tv-editors-picks-heart-icon').remove(); 
                    \$('.tv-chart-view__disclaimer-wrapper').remove(); 
                    \$('.tv-comment-tree').remove(); 
                    \$('.tv-chart-view__social-links').remove(); 
                    \$('.js-social-links-container').remove();  
                    \$('.tv-chart-view__info-area').remove();  
                    \$('.tv-chart-view__signature').remove();   
                    \$('.tv-widget-idea__social-row').remove();   
                    \$('.tv-load-more--sticky js-feed-navigation').remove();  
                    \$('.tv-chart-view__info').remove();  
                    \$('.tv-social-row--full-width').remove();  
                    \$('.tv-card-social-item').remove();  
                    
                  });
                  """);
                      isLoading = false;
                    });
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    final uri = navigationAction.request.url!;
                    if (uri.toString().contains('tradingview.com')) {
                      return NavigationActionPolicy.ALLOW;
                    }
                    return NavigationActionPolicy.CANCEL;
                  },
                  initialUserScripts: UnmodifiableListView([
                    UserScript(source: """
                  window.addEventListener('DOMContentLoaded', function(event) { 
                    \$('.tv-header__top').remove(); 
                    \$('.tv-category-header__content').remove();
                    \$('footer').remove();
                    \$('.footer').remove();  
                    \$('.tv-social-row__start').remove();  
                    \$('.tv-social-row__end--adjusted').remove();   
                    \$('.tv-feed-widget--freeze-margin').remove(); 
                    \$('.tv-editors-picks-heart-icon').remove(); 
                    \$('.tv-chart-view__disclaimer-wrapper').remove(); 
                    \$('.tv-comment-tree').remove(); 
                    \$('.tv-chart-view__social-links').remove(); 
                    \$('.js-social-links-container').remove();   
                    \$('.tv-chart-view__signature').remove();  
                    \$('.tv-widget-idea__social-row').remove();   
                    \$('.tv-load-more--sticky js-feed-navigation').remove();  
                    \$('.tv-chart-view__info').remove();  
                      \$('.tv-social-row--full-width').remove();  
                    \$('.tv-card-social-item').remove();  

                  });
                  """, injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
                  ]),
                ),
                if (isLoading)
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          ))),
    );
  }
}
