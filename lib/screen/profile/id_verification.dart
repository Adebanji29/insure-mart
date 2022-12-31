import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';
import '../../widget/containers.dart';
import '../../widget/text_fields.dart';

class IdVerification extends StatefulWidget {
  const IdVerification({Key? key}) : super(key: key);
  static const route = '/idVerify';

  @override
  State<IdVerification> createState() => _IdVerificationState();
}

class _IdVerificationState extends State<IdVerification> {
  final List<String> _idTypeList = ['National ID'];
  String? _idType;
  late TextEditingController _idNumber;

  @override
  void initState() {
    _idNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ID Verification'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label('ID Front'),
                IdContainer(
                  buttonText: 'UPLOAD IMAGE',
                  onPressed: () {},
                ),
                const SizedBox(height: 25),
                label('ID Back'),
                IdContainer(
                  buttonText: 'UPLOAD IMAGE',
                  onPressed: () {},
                ),
                const SizedBox(height: 25),
                label('ID Type'),
                CustomDropDownButton(
                  items: _idTypeList,
                  focusColor: InsuremartTheme.blue2,
                  onChanged: (val) {
                    _idType = val;
                  },
                  label: 'ID Type',
                ),
                const SizedBox(height: 25),
                label('ID Number'),
                CustomTextField(
                  controller: _idNumber,
                  focusColor: InsuremartTheme.blue2,
                  label: 'ID Number',
                ),
                const SizedBox(height: 25),
                LongButton(title: 'SAVE', onPressed: () {}),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
