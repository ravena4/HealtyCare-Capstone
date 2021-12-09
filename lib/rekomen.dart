import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_care/detail_page.dart';
import 'package:healthy_care/makanan.dart';
import 'package:healthy_care/platform_widget.dart';
import 'package:healthy_care/styles.dart';

class rekomen extends StatelessWidget {
  @override 
  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString('assets/makanan.json'),
      builder: (context, snapshot) {
        final List<Makanan> makanan = parseMakanan(snapshot.data);
        return ListView.builder(
          itemCount: makanan.length,
          itemBuilder: (context, index) {
            return _buildMakananItem(context, makanan[index]);
          },
        );
      },
    );
}
  Widget _buildMakananItem(BuildContext context, Makanan makanan) {
    return Material(
      color: Colors.black,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: makanan.urlToImage,
          child: Image.network(
            makanan.urlToImage,
            width: 100,
          ),
        ),
        title: Text(
          makanan.title,
        ),
        subtitle: Text(makanan.author),
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => MakananDetailPage() ));
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rekomendasi'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Rekomendasi'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
