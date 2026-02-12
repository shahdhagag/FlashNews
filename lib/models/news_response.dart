import 'package:hive_flutter/adapters.dart';
import 'package:newsApp/models/source_response.dart';
part 'news_response.g.dart';

@HiveType(typeId: 2)
class NewsResponse extends HiveObject {
  NewsResponse({
    this.status,
    this.totalResults,
    this.articles,
    this.message,
    this.code,
  });

  NewsResponse.fromJson(dynamic json) {
    status = json['status'];
    totalResults = json['totalResults'];
    message = json['message'];
    code = json['code'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(Articles.fromJson(v));
      });
    }
  }
  @HiveField(0)
  String? status;
  @HiveField(1)
  int? totalResults;
  @HiveField(2)
  List<Articles>? articles;
  @HiveField(3)
  String? message;
  @HiveField(4)
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['totalResults'] = totalResults;
    map['message'] = message;
    map['code'] = code;
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
@HiveType(typeId: 3)
class Articles extends HiveObject{
  Articles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Articles.fromJson(dynamic json) {
    source = json['source'] != null ? Sources.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
  @HiveField(0)
  Sources? source;
  @HiveField(1)
  String? author;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? urlToImage;
  @HiveField(6)
  String? publishedAt;
  @HiveField(7)
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (source != null) {
      map['source'] = source?.toJson();
    }
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['urlToImage'] = urlToImage;
    map['publishedAt'] = publishedAt;
    map['content'] = content;
    return map;
  }
}
