import 'package:afer/const/photo_manger.dart';
import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:afer/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
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
  late AppCubit cubit;
  @override
  void initState() {
    if( AppCubit.get(context).video.id != null) {
      AppCubit.get(context).getIfVideoPayed(uidVideo: AppCubit
          .get(context)
          .video
          .id!, isPayed: true).then((value) {
        if (value == false) {
          AppCubit.get(context).changeIndexTap(1);
        }
      });
    }
    if (AppCubit.get(context).video.linkVideo != null) {
      if (AppCubit.get(context).vidoe != null) {
        flickManager = FlickManager(
          videoPlayerController:
          VideoPlayerController.file(AppCubit.get(context).vidoe!),
          autoPlay: false,
        );
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    if(cubit.video.linkVideo != null) {
      flickManager.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit= AppCubit.get(context);
        return ConditionalBuilder(
            fallback: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(PhotoManger.notFound, fit: BoxFit.fill),
                    Text(
                      LocaleKeys.notFoundVideo.tr(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'Stoor',
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            condition: AppCubit.get(context).video.linkVideo != null &&!flickManager.flickVideoManager!.videoPlayerValue!.hasError,
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
                            child: Text(
                                AppCubit.get(context).video.description!,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        if (AppCubit.get(context).photo.isNotEmpty)
                          SizedBox(
                            width: 120,
                            child: MainButton(
                              fct: () {
                                BlocProvider.of<AppCubit>(context)
                                    .showImageVideo();
                              },
                              text: LocaleKeys.summary.tr(),
                            ),
                          ),
                        if (BlocProvider.of<AppCubit>(context)
                            .showImageUnderVideo)
                          SizedBox(
                            height: 500,
                            width: 500,
                            child: ListView.separated(
                                itemBuilder: (context, i) {
                                  return Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 250,
                                    height: 250,
                                    child: CachedNetworkImage(
                                      imageUrl:     AppCubit.get(context).photo[i].linkPhoto??"",
                                      imageBuilder: (context,image)=>PhotoView(
                                        filterQuality: FilterQuality.high,
                                        imageProvider: image,
                                      ),
                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      cacheKey:  AppCubit.get(context).photo[i].linkPhoto,

                                    ),

                                  );
                                },
                                separatorBuilder: (context, i) =>
                                    const SizedBox(height: 10),
                                itemCount: AppCubit.get(context).photo.length),
                          )
                      ]),
                    )),
              );
            });
      },
    );
  }
}
