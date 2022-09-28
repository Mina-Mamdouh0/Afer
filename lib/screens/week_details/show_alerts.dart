
import 'package:flutter/material.dart';

class ShowAlerts extends StatelessWidget {
  const ShowAlerts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'ShowAlertsShowAlertsShowAlertsShowAlertsShowAlertsShowAlertsShowAlerts',
          style:   TextStyle(
            fontSize: 25,
            fontFamily: 'Stoor',
            fontWeight: FontWeight.normal,
          ),
          textAlign:  TextAlign.center,
        ),
      ),
    );
  }
}
