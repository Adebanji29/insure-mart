import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import 'buttons.dart';


Future buildBottomSheet(context) {

  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LongButton(title: 'SAVE AS DRAFT', onPressed: () {;

              }),
              const SizedBox(height: 15),
              LongButton(
                title: 'DELETE DRAFT',
                onPressed: () {},
                isBorder: true,
                color: InsuremartTheme.white1,
                borderColor: InsuremartTheme.red3,
                textColor: InsuremartTheme.red3,
              ),
              const SizedBox(height: 15),
              LongButton(
                title: 'CANCEL',
                onPressed: () {},
                isBorder: true,
                color: InsuremartTheme.white1,
                textColor: InsuremartTheme.blue2,
              ),
            ],
          ),
        );
      });
}

