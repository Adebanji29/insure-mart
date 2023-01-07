import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insuremart_app/provider/insurance_provider.dart';
import 'package:provider/provider.dart';

import '../provider/new_claim_provider.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      actions: actions,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class ImageSourceDialogBox extends StatelessWidget {
  const ImageSourceDialogBox({
    super.key,
    required this.which,
    this.isClaim = true,
  });
  final String which;
  final bool isClaim;

  @override
  Widget build(BuildContext context) {
    final claimProvider = context.read<NewClaimProvider>();
    final insuranceProvider = context.read<InsuranceProvider>();
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Pick from Camera"),
              onTap: () async {
                Navigator.pop(context);
                isClaim
                    ? claimProvider.pickImage(
                        source: ImageSource.camera, which: which)
                    : insuranceProvider.pickImage(
                        source: ImageSource.camera, which: which);
                // getImage(source: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text("Pick from Gallery"),
              onTap: () async {
                Navigator.pop(context);
                isClaim
                    ? claimProvider.pickImage(
                        source: ImageSource.gallery, which: which)
                    : insuranceProvider.pickImage(
                        source: ImageSource.gallery, which: which);
                // getImage(source: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
