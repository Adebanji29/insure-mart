import 'package:flutter/material.dart';

import '../utils/app_theme.dart';




linearProgressBar()
{
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 14),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(InsuremartTheme.blue2),
    ),
  );
}