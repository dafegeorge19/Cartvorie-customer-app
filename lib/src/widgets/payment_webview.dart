import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutPage extends StatefulWidget {
  final String sessionId;

  const CheckoutPage({Key key, this.sessionId}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WebView(
          initialUrl: initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) => _controller = controller,
          onPageFinished: (String url) {
            //<---- add this
            if (url == initialUrl) {
              _redirectToStripe(widget.sessionId);
            }
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://success.com')) {
              Navigator.of(context).pop('success');
            } else if (request.url.startsWith('https://cancel.com')) {
              Navigator.of(context).pop('cancel');
            }
            return NavigationDecision.navigate;
          }),
    );
  }

  Future<String> _redirectToStripe(String sessionId) {
    //<--- prepare the JS in a normal string
    var apiKey =
        "pk_test_51GvhodAXfbRaLyKm76JYtBF0IAm2rQay29miEeheTZSrjNqbhHyfoJEuSd8w7Rbo6FWCrTyvcpRep93lRbBAEVZP00ZzxsZBgC";
    final redirectToCheckoutJs = '''
      var stripe = Stripe(\'$apiKey\');
          
      stripe.redirectToCheckout({
        sessionId: '${widget.sessionId}'
      }).then(function (result) {
        result.error.message = 'Error'
      });
    ''';
    _controller.evaluateJavascript(
        redirectToCheckoutJs); //<--- call the JS function on controller
  }

  String get initialUrl =>
      'data:text/html;base64,${base64Encode(Utf8Encoder().convert(kStripeHtmlPage))}';
}

const kStripeHtmlPage = '''
<!DOCTYPE html>
<html>
<script src="https://js.stripe.com/v3/"></script>
<head><title>Stripe checkout</title></head>
<body>
Hello Webview
</body>
</html>
''';
