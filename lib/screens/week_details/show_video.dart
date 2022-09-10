
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class ShowVideo extends StatefulWidget {
  const ShowVideo({Key? key}) : super(key: key);

  @override
  State<ShowVideo> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(AppCubit.get(context).video!.linkVideo!),
    );
  }
  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (context,state){
        return  SingleChildScrollView(
          child: Padding(
              padding: EdgeInsetsDirectional.only(end: 10,start: 10),
              child: Card(
                child: Column(
                    children:[
                      ClipRect(
                        child: AspectRatio(aspectRatio: flickManager.flickVideoManager!.videoPlayerValue!.aspectRatio,
                          child: FlickVideoPlayer(
                              flickManager: flickManager
                          ),
                        ),

                      ),
                      Container(padding: EdgeInsetsDirectional.all(10),
                        child: Text(AppCubit.get(context).video!.description!,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),)
                    ] ),
              )
          ),
        );
      },

    );
  }
}


