import 'dart:typed_data';

import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';

class ShowLecture extends StatefulWidget {
  const ShowLecture({Key? key}) : super(key: key);

  @override
  State<ShowLecture> createState() => _ShowLectureState();
}

class _ShowLectureState extends State<ShowLecture> {
  static const int _initialPage = 0;
  bool _isSampleDoc = true;
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openData(AppCubit.get(context).bytes),
      initialPage: _initialPage,
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: AppCubit.get(context).bytes != Uint8List(0),
      builder: (context)=>Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
             leading: const SizedBox(),
            actions:[
              IconButton(
                icon: const Icon(Icons.navigate_before),
                onPressed: () {
                  _pdfController.previousPage(
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 100),
                  );
                },
              ),
              PdfPageNumber(
                controller: _pdfController,
                builder: (_, loadingState, page, pagesCount) => Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$page/${pagesCount ?? 0}',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.navigate_next),
                onPressed: () {
                  _pdfController.nextPage(
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 100),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if (_isSampleDoc) {
                    _pdfController.loadDocument(
                        PdfDocument.openData(AppCubit.get(context).bytes));
                  } else {
                    _pdfController
                        .loadDocument(PdfDocument.openData(AppCubit.get(context).bytes));
                  }
                  _isSampleDoc = !_isSampleDoc;
                },
              ),
            ],
          ),

          body: BlocConsumer<AppCubit,AppState>(
              listener: (context, state) {},
              builder: (context,state) {
                return PdfView(
                  builders: PdfViewBuilders<DefaultBuilderOptions>(
                    options: const DefaultBuilderOptions(),
                    documentLoaderBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                    pageLoaderBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                    pageBuilder: _pageBuilder,
                  ),
                  controller: _pdfController,
                );
              }
          ),
        ),
      fallback: (context)=>const Center(child: CircularProgressIndicator()),

    );
  }

  PhotoViewGalleryPageOptions _pageBuilder(
      BuildContext context,
      Future<PdfPageImage> pageImage,
      int index,
      PdfDocument document,
      ) {
    return PhotoViewGalleryPageOptions(
      imageProvider: PdfPageImageProvider(
        pageImage,
        index,
        document.id,
      ),
      minScale: PhotoViewComputedScale.contained * 1,
      maxScale: PhotoViewComputedScale.contained * 2,
      initialScale: PhotoViewComputedScale.contained * 1.0,
      heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
    );
  }
}