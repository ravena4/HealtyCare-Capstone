 import 'package:healthy_care/web_view.dart';
 import 'package:flutter/material.dart';
 import 'package:healthy_care/makanan.dart';

class MakananDetailPage extends StatelessWidget {
  static const routeName = '/makanan_detail';

  final Makanan makanan;

  const MakananDetailPage({ this.makanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recomendasi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           // Hero(
              //  tag: makanan.urlToImage,
               // child: Image.network(makanan.urlToImage )
             //  ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    makanan.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Divider(color: Colors.grey),
                  Text(
                   makanan.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    'Date: ${makanan.publishedAt}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Author: ${makanan.author}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    makanan.content,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Read more'),
                    onPressed: () {
                      Navigator.pushNamed(context, MakananWebView.routeName,
                          arguments: makanan.url);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
