
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class NasaWebView extends StatefulWidget {
  final String url;
  NasaWebView(this.url);

  @override
  State<StatefulWidget> createState() {
    return NasaWebViewState();
  }
}

class NasaWebViewState extends State<NasaWebView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // constraints: BoxConstraints(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical,
           width: MediaQuery.of(context).size.width - MediaQuery.of(context).padding.horizontal,//),

      child: Stack(
        children: [
          //Image.memory(kTransparentImage),
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center(child: CircularProgressIndicator()) : SizedBox(width: 0, height: 0)
        ],
      )
    );
  }
}