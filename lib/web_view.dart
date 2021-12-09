import 'package:healthy_care/custom_scaffold.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MakananWebView extends StatelessWidget {
  static const routeName = '/makanan_web';

  final String url;

  const MakananWebView({ this.url});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
