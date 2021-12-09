import 'dart:convert';

class Makanan {
   String author;
   String title;
   String description;
   String url;
   String urlToImage;
   String publishedAt;
   String content;

  Makanan({
     this.author,
     this.title,
     this.description,
     this.url,
     this.urlToImage,
     this.publishedAt,
     this.content,
  });

  Makanan.fromJson(Map<String, dynamic> makanan) {
    author = makanan['author'];
    title = makanan['title'];
    description = makanan['description'];
    url = makanan['url'];
    urlToImage = makanan['urlToImage'];
    publishedAt = makanan['publishedAt'];
    content = makanan['content'];
  }
}

List<Makanan> parseMakanan(String json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Makanan.fromJson(json)).toList();
}
