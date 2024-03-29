import 'package:afer/const/photo_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
    if (AppCubit.get(context).video.linkVideo != null) {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
            AppCubit.get(context).video.linkVideo!),
      );
    }
  }

  @override
  void dispose() {

      flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            fallback: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(PhotoManger.notFound,
                        fit: BoxFit.fill),
                     Text(
                      LocaleKeys.notFoundVideo.tr(),
                       style: const TextStyle(
                         fontSize: 22,
                         fontFamily: 'Stoor',
                         fontWeight: FontWeight.normal,
                       ),
                       textAlign:  TextAlign.center,

                    ),
                  ],
                ),
            condition: AppCubit.get(context).video.linkVideo != null &&
                AppCubit.get(context).video.description != null,
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(end: 10, start: 10),
                    child: Card(
                      child: Column(children: [
                        ClipRect(
                          child: AspectRatio(

                            aspectRatio: flickManager.flickVideoManager!
                                .videoPlayerValue!.aspectRatio,
                            child: FlickVideoPlayer(flickManager: flickManager),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.all(10),
                          child: Text(AppCubit.get(context).video.description!,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        if(AppCubit.get(context).photo.linkPhoto!=null)
                        SizedBox(
                          width: 120,
                          child: MainButton(
                            fct: (){
                              BlocProvider.of<AppCubit>(context).showImageVideo();
                            },
                            text:LocaleKeys.summary.tr() ,
                          ),
                        ),
                        if(BlocProvider.of<AppCubit>(context).showImageUnderVideo)
                          Container(
                                margin: const EdgeInsets.all(10),
                                width: double.infinity,
                                height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(AppCubit.get(context).photo.linkPhoto!),
                                fit: BoxFit.fill,
                              ),
                            ),
                              )



                      ]),
                    )),
              );
            });
      },
    );
  }
}
