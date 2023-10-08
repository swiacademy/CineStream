import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies_apps_bloc_pattern/ui/components/video_player.dart';

class TrailerMovie extends StatefulWidget {
  const TrailerMovie({super.key});

  @override
  State<TrailerMovie> createState() => _TrailerMovieState();
}

class _TrailerMovieState extends State<TrailerMovie> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments = Get.arguments;

    // return Scaffold(
    //   body: NestedScrollView(
    //     scrollDirection: Axis.vertical,
    //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //       return [
    //         SliverAppBar(
    //           title: Text(arguments[0]["title"]),
    //           elevation: 10.0,
    //           automaticallyImplyLeading: true,
    //           expandedHeight: 50,
    //           floating: true,
    //           snap: true,
    //         )
    //       ];
    //     },
    //     body: SizedBox(
    //         width: MediaQuery.of(context).size.width,
    //         child: VideoPlayer(arguments[0]['youtubeId'])),
    //   ),
    // );
    return Scaffold(
        appBar: AppBar(
          title: Text(arguments[0]["title"]),
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: VideoPlayer(arguments[0]['youtubeId']))
        // Text(arguments[0]['youtubeId']),
        );
  }
}
