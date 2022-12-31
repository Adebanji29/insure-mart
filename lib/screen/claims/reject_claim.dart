import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';

class RejectClaim extends StatefulWidget {
  const RejectClaim({Key? key}) : super(key: key);
  static const route = '/rejectClaim';

  @override
  State<RejectClaim> createState() => _RejectClaimState();
}

class _RejectClaimState extends State<RejectClaim> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _reason;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _reason = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reject Claim'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 323),
            children: [
              label('Reason'),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                constraints: const BoxConstraints(minHeight: 267),
                decoration: BoxDecoration(
                  color: InsuremartTheme.white2,
                  border: Border.all(color: InsuremartTheme.white3),
                ),
                child: TextFormField(
                  controller: _reason,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (value.length > 20) {
                      return 'At least 20 character is required';
                    }
                    return null;
                  },
                  // validator: reasonValidator,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Reason',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              LongButton(title: 'REJECT OFFER', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
