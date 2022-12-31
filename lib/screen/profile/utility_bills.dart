import 'package:flutter/material.dart';


import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';
import '../../widget/containers.dart';
import '../../widget/text_fields.dart';

class UtilityBills extends StatelessWidget {
    UtilityBills({Key? key}) : super(key: key);
   static const route = '/utilityBills';
  final List<String> _billTypeList = const ['', ''];

   String? _utilityBillType;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Utility Bill'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label('Utility Bill'),
              IdContainer(buttonText: 'UPLOAD IMAGE', onPressed: () {}),
              const SizedBox(height: 25),
              label('Utility Bill Type'),
              CustomDropDownButton(
                label: 'Utility Bill Type',
                focusColor: InsuremartTheme.blue2,
                items: _billTypeList,
                onChanged: (val) {
                  _utilityBillType = val;
                },
              ),
              const SizedBox(height: 25),
              LongButton(title: 'SAVE', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
