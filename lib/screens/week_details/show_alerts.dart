import 'package:afer/cuibt/app_cuibt.dart';
import 'package:afer/cuibt/app_states.dart';
import 'package:afer/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAlerts extends StatelessWidget {
  const ShowAlerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AppCubit, AppState>(
          bloc: AppCubit(),
          builder: (context, state) {
            return  Text(
            context.read<AppCubit>().subjectNotes.isNotEmpty? context.read<AppCubit>().subjectNotes:LocaleKeys.noNotes.tr(),
              style: const TextStyle(
                fontSize: 25,
                fontFamily: 'Stoor',
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}
