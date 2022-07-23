import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import '../services/dioSingletion.dart';

class Video{
  String? url;
  String? thumbnail;
  String? title;
  Video({this.url, this.thumbnail, this.title});

  @override
  String toString() {
    return 'Video{url: $url, thumbnail: $thumbnail, title: $title}';
  }

  static Future<Video> getData(String url) async{
    Dio dio = DioSingleton.dio;
    Map<String, dynamic> data = {
      "url": null,
      "thumbnail": null,
      "title": null
    };
    Response<dynamic> response = await dio.get(url, options: Options(headers: {
      "User-Agent": "Mozilla/5.0 (Linux; Android 11; SAMSUNG SM-G973U) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/14.2 Chrome/87.0.4280.141 Mobile Safari/537.36"
    }));
    var document = parse(response.data);
    document.getElementsByTagName("meta").forEach((element) {
      // print(element.attributes);
      if(element.attributes.containsValue("og:video")) {
        data["url"] = element.attributes["content"];
        return;
      }
      if(element.attributes.containsValue("og:image")){
        data["thumbnail"] = element.attributes["content"];
        return;
      }
      if(element.attributes.containsValue("twitter:title")){
        data["title"] = element.attributes["content"];
        return;
      }
    });
    return Video(
        url: data["url"],
        thumbnail: data["thumbnail"],
        title: data["title"]
    );
      }
}

