import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../utils/functions.dart';
import 'dart:io' as io;

class MyWebviewWidget extends StatefulWidget {
  final String title;
  final String urlToUse;
  const MyWebviewWidget({
    required this.title,
    required this.urlToUse,
    super.key,
  });

  @override
  State<MyWebviewWidget> createState() => _MyWebviewWidgetState();
}

class _MyWebviewWidgetState extends State<MyWebviewWidget> {
  InAppWebViewController? webViewController;
  // WebViewModel? ebViewModel;

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return; // Already handled by system
        try {
          if (webViewController != null &&
              await webViewController!.canGoBack()) {
            await webViewController!.goBack();
            getLog("web", "qwertyuio");
          } else if (Navigator.of(context).canPop()) {
            // Only attempt to pop if it's possible
            Navigator.of(context).pop();
            getLog("flutter", "qwertyuio");
          } else {
            getLog("flutter", "no more pages to pop");
            // Do nothing or show a dialog, as there's nowhere else to go
          }
        } catch (e) {
          getLog("error", e.toString());
        }
      },
      child: Scaffold(
        // appBar:widget.title!=null? AppBar(
        //   centerTitle: true,
        //   leading: GestureDetector(
        //     onTap: () async {
        //       if (await webViewController!.canGoBack()) {
        //         await webViewController!.goBack();
        //       } else {
        //         navigatorKey.currentState!.pop();
        //         if (webViewController != null) {
        //           await InAppWebViewController.clearAllCache();
        //           // CookieManager().removeSessionCookies();
        //           CookieManager().deleteAllCookies();
        //         }
        //       }
        //     },
        //     child: const Icon(Icons.arrow_back),
        //   ),
        //   title: Text(
        //     widget.title,
        //     style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        //   ),
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.urlToUse)),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                initialSettings: InAppWebViewSettings(
                  // allowUniversalAccessFromFileURLs: true,
                  allowFileAccessFromFileURLs: true,
                  javaScriptEnabled: true,
                  useHybridComposition: true,
                  useOnDownloadStart: true,
                  allowFileAccess: true,
                  userAgent:
                      "Mozilla/5.0 (Linux; Android 12; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Mobile Safari/537.36",

                  // clearCache: true,
                  // clearSessionCache: true,
                  // cacheEnabled: false,
                  // incognito: true,
                  // useShouldOverrideUrlLoading: true,
                  allowsBackForwardNavigationGestures: true,
                  javaScriptCanOpenWindowsAutomatically: true,
                  supportMultipleWindows: true,
                ),
                onLoadStart: (controller, url) async {
                  debugPrint("onLoadStart:$url");

                  String urlNavigate = url.toString();
                  if (urlNavigate.startsWith('https://www.youtube.com/')) {
                    return;
                  }
                  if (urlNavigate.startsWith('tel:')) {
                    await webViewController!.stopLoading();
                    FunctionsUtils.launchURL(urlNavigate);
                    // Open phone dialer for calls
                  } else if (urlNavigate.startsWith('whatsapp://')) {
                    await webViewController!.stopLoading();
                    FunctionsUtils.launchURL(urlNavigate);
                    // // Open WhatsApp for specific URLs
                  }
                  setState(() {
                    _isLoading = true;
                  });
                  return;
                },
                // onCreateWindow: (controller, createWindowRequest) async {
                //   final url = createWindowRequest.request.url?.toString();
                //   // if (url != null) {
                //     FunctionsUtils.launchURL(url!);
                //   // }
                //   return false; // prevents WebView from handling it internally
                // },
                onCreateWindow: (controller, createWindowRequest) async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        width: 1,
                        height: 1,
                        child: InAppWebView(
                          windowId: createWindowRequest.windowId,
                          initialSettings: InAppWebViewSettings(
                            javaScriptEnabled: true,
                            useShouldOverrideUrlLoading: true,
                          ),
                          onLoadStart: (popupController, url) {
                            if (url.toString() != 'about:blank') {
                              Navigator.of(
                                context,
                              ).pop(); // close hidden dialog
                              FunctionsUtils.launchURL(url.toString());
                            }
                          },
                        ),
                      ),
                    ),
                  );

                  return true; // Let WebView handle this new window
                },

                onLoadStop: (controller, url) async {
                  debugPrint("onLoadStop:$url");
                  setState(() {
                    _isLoading = true;
                  });
                },
                onDownloadStartRequest: (controller, url) async {
                  final cookies = await CookieManager.instance().getCookies(
                    url: url.url,
                  );
                  final ioCookies = cookies
                      .map((c) => io.Cookie(c.name, c.value))
                      .toList();
                  FunctionsUtils.downloadFileWebView(
                    context,
                    url.url,
                    ioCookies,
                  );
                },
              ),
              if (!_isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
