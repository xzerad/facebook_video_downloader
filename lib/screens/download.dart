import 'package:fb_video_downloader/services/dioSingletion.dart';
import 'package:flutter/material.dart';

import '../models/video.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({Key? key, required this.data}) : super(key: key);
  final Video data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Body(data: data),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key, required this.data}) : super(key: key);
  final Video data;

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {
  double percentage = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    download();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.network(widget.data.thumbnail!, width: size.width *0.8,)),
        SizedBox(height: size.height * .05,),
        SizedBox(
          width: size.width*.9,
          child: LinearProgressIndicator(
            color: Colors.green,
            minHeight: 30,
            value: percentage,

          ),
        )
      ],
    );
  }
  download(){
    DioSingleton.dio.download(widget.data.url, "/storage/emulated/0/Download/${widget.data.title}.mp4", onReceiveProgress: (received, total){
      // print((received/total)*100);
      setState(() {
        percentage = (received / total);
      });
    });
  }

}

