import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';

import '../../translations/locale_keys.g.dart';

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
    AppCubit.get(context).getIfPdfPayed(uidPdf:  AppCubit.get(context).pdf.id!, isPayed: AppCubit.get(context).pdf.isPaid!).then((value) {
      if(value==false){
        AppCubit.get(context).   changeIndexTap(0);

      }
    } );
    _pdfController = PdfController(
      document: PdfDocument.openData(AppCubit.get(context).bytes),
      initialPage: _initialPage,
    );
    super.initState();

  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return ConditionalBuilder(
      condition: AppCubit.get(context).pdf.linkPdf != null &&
          AppCubit.get(context).pdf.linkPdf!.isNotEmpty &&
          AppCubit.get(context).bytes.isNotEmpty,
        builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const SizedBox(),
          actions: [
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
                  _pdfController.loadDocument(
                      PdfDocument.openData(AppCubit.get(context).bytes));
                }
                _isSampleDoc = !_isSampleDoc;
              },
            ),
          ],
        ),
        body: BlocConsumer<AppCubit, AppStates>(

            listener: (context, state) {},
            builder: (context, state) {
              return PdfView(
                builders: PdfViewBuilders<DefaultBuilderOptions>(
                  errorBuilder: (context, error) => Center(
                    child:  IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        if (_isSampleDoc) {
                          _pdfController.loadDocument(
                              PdfDocument.openData(AppCubit.get(context).bytes));
                        } else {
                          _pdfController.loadDocument(
                              PdfDocument.openData(AppCubit.get(context).bytes));
                        }
                        _isSampleDoc = !_isSampleDoc;
                      },
                    ),
                  ),
                  options: const DefaultBuilderOptions(),
                  documentLoaderBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  pageLoaderBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  pageBuilder: _pageBuilder,
                ),
                controller: _pdfController,
                onDocumentError: (error) {

                  _pdfController.loadDocument(
                      PdfDocument.openData(AppCubit.get(context).bytes));
                },

              );
            }),
      ),
      fallback: (context) {
        if(AppCubit.get(context).pdf.linkPdf != null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return  Center(
            child: Text(
              LocaleKeys.noPdfYet.tr(),
              style: const TextStyle(
                fontSize: 22,
                fontFamily: 'Stoor',
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
      }
    );
  },
);
  }

  PhotoViewGalleryPageOptions _pageBuilder(
    BuildContext context,
    Future<PdfPageImage> pageImage,
    int index,
    PdfDocument document,
  ) {
    return PhotoViewGalleryPageOptions(
      filterQuality: FilterQuality.high,
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
