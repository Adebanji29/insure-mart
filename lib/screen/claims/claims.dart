import 'package:flutter/material.dart';
import 'package:insuremart_app/service/claim_service.dart';

import 'package:provider/provider.dart';

import '../../models/claim_model.dart';
import '../../provider/claim_provider.dart';
import '../../utils/app_theme.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import '../../widget/custom_progress_indicator.dart';
import './claim_discharge.dart';
import './new_claim.dart';
import './reject_claim.dart';

class MyClaims extends StatefulWidget {
  const MyClaims({Key? key}) : super(key: key);

  @override
  State<MyClaims> createState() => _MyClaimsState();
}

class _MyClaimsState extends State<MyClaims> {
  late Stream<List<Claim>> streamData;

  @override
  void initState() {
    streamData = ClaimService().claims;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final claims = Provider.of<List<Claim>>(context);
    // List<Claim> claimlist = claims;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Claims'),
        centerTitle: false,
        titleSpacing: 20,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NewClaim.route),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<void>(
          stream: streamData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: claims.length,
              itemBuilder: (_, index) {
                final claim = claims[index];
                return Provider.value(
                  value: claim,
                  child: ClaimItemCard(
                    myIndex: index,
                  ),
                );
              },
              separatorBuilder: (_, __) => const CustomSizedBox(height: 20),
            );
          }),
    );
  }
}

// extension StringTitleExtension on String {
//   String get toTitle => split(' ')
//       .map((str) => str[0].toUpperCase() + str.substring(1))
//       .join(' ');
// }

class ClaimItemCard extends StatelessWidget {
  final int myIndex;
  const ClaimItemCard({super.key, required this.myIndex});

  @override
  Widget build(BuildContext context) {
    final claim = context.read<Claim>();
    final claiman = context.read<ClaimProvider>();
    return buildItemCard(context, claim, claiman);
    // return buildItemCard(claim, claiman);
  }

  Container buildItemCard(
      BuildContext context, Claim claim, ClaimProvider claiman) {
    if (claim.status.toLowerCase() == 'claim settled' ||
        claim.status.toLowerCase() == 'offer recieved') {
      return Container(
        padding:
            const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 23),
        decoration: BoxDecoration(
          color: InsuremartTheme.white4,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Claim #${claim.id}',
              style: InsuremartTheme.lightTextTheme.bodyText1,
            ),
            const CustomSizedBox(height: 25),
            labelText('Claim Status'),
            const CustomSizedBox(height: 7),
            CustomLinearProgressIndicator(
              max: 4,
              current: claiman.claimLevel(claim.status),
              color: claiman.claimColor(claim.status),
            ),
            const CustomSizedBox(height: 7),
            Text(
              claim.status,
              // claim.status.toTitle,
              style: InsuremartTheme.lightTextTheme.headline2!.copyWith(
                fontSize: 18,
                color: claiman.claimColor(claim.status),
              ),
            ),
            const CustomSizedBox(height: 25),
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  iconColor: const Color(0xff323232),
                  collapsedIconColor: const Color(0xff323232),
                  tilePadding: const EdgeInsets.only(left: 15),
                  childrenPadding: const EdgeInsets.only(left: 15),
                  expandedAlignment: Alignment.topLeft,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  backgroundColor: const Color(0xffd5d5d5),
                  collapsedBackgroundColor: const Color(0xffd5d5d5),
                  title: Text(
                    'Claim Details',
                    style: InsuremartTheme.lightTextTheme.bodyText1,
                  ),
                  children: [
                    labelText('Asset'),
                    const CustomSizedBox(height: 5),
                    Text(
                      claim.assets,
                      // claim.assets.toTitle,
                      style: InsuremartTheme.lightTextTheme.headline3!
                          .copyWith(fontSize: 12),
                    ),
                    const CustomSizedBox(height: 20),
                    labelText('Policy / Policy Number'),
                    Text(
                      claim.assets,
                      style: InsuremartTheme.lightTextTheme.headline3!
                          .copyWith(fontSize: 12),
                    ),
                    const CustomSizedBox(height: 20),
                    labelText('Date Of Incident'),
                    const CustomSizedBox(height: 5),
                    buildText(claim.dateOfIncident),
                    const CustomSizedBox(height: 20),
                    labelText('Claim Description'),
                    const CustomSizedBox(height: 5),
                    buildText(claim.description),
                    const CustomSizedBox(height: 20),
                    labelText('Claimed Amount'),
                    Text(
                      claim.claimedAmount!,
                      style: InsuremartTheme.lightTextTheme.headline2!
                          .copyWith(fontSize: 12),
                    ),
                    const CustomSizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const CustomSizedBox(height: 25),
            labelText('Final Offer'),
            Text(
              claim.claimedAmount!,
              style: InsuremartTheme.lightTextTheme.headline3!.copyWith(
                fontSize: 18,
                color: InsuremartTheme.green1,
              ),
            ),
            const SizedBox(height: 19),
            Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: const Color(0xff323232),
                collapsedIconColor: const Color(0xff323232),
                title: Text(
                  'View Offer Details',
                  style: InsuremartTheme.lightTextTheme.headline3!
                      .copyWith(fontSize: 14),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 20),
                    decoration: BoxDecoration(
                      color: const Color(0xffd5d5d5),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelText('Final Offer'),
                        Text(
                          claim.offerDetail!,
                          style: InsuremartTheme.lightTextTheme.headline2!
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (claim.status.toLowerCase() == 'offer recieved') ...[
                    const CustomSizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MediumButton(
                          height: 56,
                          width: 147.5,
                          color: const Color(0xffd6d6d6),
                          titleColor: InsuremartTheme.blue4,
                          onPressed: () => Navigator.of(context)
                              .pushNamed(ClaimDischarge.route),
                          title: 'ACCEPT',
                        ),
                        const SizedBox(width: 10),
                        MediumButton(
                          height: 56,
                          width: 147.5,
                          color: const Color(0xffd6d6d6),
                          titleColor: InsuremartTheme.red2,
                          onPressed: () => Navigator.of(context)
                              .pushNamed(RejectClaim.route),
                          title: 'REJECT',
                        ),
                      ],
                    )
                  ],
                  const CustomSizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 23),
      decoration: BoxDecoration(
        color: InsuremartTheme.white4,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Claim #${claim.id}',
            style: InsuremartTheme.lightTextTheme.bodyText1,
          ),
          const CustomSizedBox(height: 25),
          labelText('Claim Status'),
          const CustomSizedBox(height: 7),
          CustomLinearProgressIndicator(
            max: 4,
            current: claiman.claimLevel(claim.status),
            color: claiman.claimColor(claim.status),
          ),
          const CustomSizedBox(height: 7),
          Text(
            claim.status,
            // claim.status.toTitle,
            style: InsuremartTheme.lightTextTheme.headline2!.copyWith(
              fontSize: 18,
              color: claiman.claimColor(claim.status),
            ),
          ),
          const CustomSizedBox(height: 25),
          labelText(claim.status.toLowerCase() == 'rejected'
              ? 'Asset'
              : 'Vehicle Make And Model'),
          const CustomSizedBox(height: 5),
          Text(
            claim.assets,
            // claim.assets.toTitle,
            style: InsuremartTheme.lightTextTheme.headline3!
                .copyWith(fontSize: 12),
          ),
          if (claim.status.toLowerCase() == 'rejected') ...[
            const CustomSizedBox(height: 25),
            labelText('Policy / Policy Number'),
            Text(
              claim.assets,
              // claim.assets.toTitle,
              style: InsuremartTheme.lightTextTheme.headline3!
                  .copyWith(fontSize: 12),
            ),
          ],
          const CustomSizedBox(height: 25),
          labelText('Date Of Incident'),
          const CustomSizedBox(height: 5),
          buildText(claim.dateOfIncident),
          const CustomSizedBox(height: 25),
          labelText('Claim Description'),
          const CustomSizedBox(height: 5),
          buildText(claim.description),
          if (claim.status.toLowerCase() == 'rejected') ...[
            const CustomSizedBox(height: 25),
            labelText('Asking Repair Amount'),
            Text(
              claim.repairAmount!,
              style: InsuremartTheme.lightTextTheme.headline2!
                  .copyWith(fontSize: 12),
            )
          ],
          const CustomSizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(
              //   onPressed: () {
              //
              //   },
              //   color: const Color(0xff4f4f4f),
              //   icon: const Icon(Icons.edit),
              // ),
              // const CustomSizedBox(width: 12),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                            "Are you sure you want to delete this claim?",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "cancel",
                                  style:
                                      TextStyle(color: InsuremartTheme.blue1),
                                )),
                            TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  claiman.deleteCard(myIndex);
                                },
                                child: const Text(
                                  "Ok",
                                  style:
                                      TextStyle(color: InsuremartTheme.blue1),
                                )),
                          ],
                        );
                      });
                },
                color: const Color(0xff4f4f4f),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      style: InsuremartTheme.lightTextTheme.subtitle1!.copyWith(
        color: InsuremartTheme.black1,
      ),
      maxLines: 2,
    );
  }

  Text labelText(String text) {
    return Text(
      text,
      style: InsuremartTheme.lightTextTheme.headline5,
    );
  }
}
