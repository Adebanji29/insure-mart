
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Backend models/cardModel.dart';
import '../provider/card_provider.dart';
import '../utils/app_theme.dart';
import '../utils/color.dart';

class CardListView extends StatefulWidget {



  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {

  var selectedIndex;


  @override
  Widget build(BuildContext context) {
    CardProvider cardprovider = Provider.of<CardProvider>(context);
    cardprovider.getCardData();
    List<CardModel> cardmodelList= cardprovider.getCardList;

    return Expanded(
      child: cardmodelList.isNotEmpty?
      ListView.separated(
          itemBuilder: (context, index) {
            return CardTile(
                onClick: (){
                  setState(() {
                    selectedIndex=index;
                  });
                },
                myIndex: index,
                model: cardmodelList[index],
                context: context,
                SelectedIndex: selectedIndex);

          },
          separatorBuilder: (context,index){
            return SizedBox(height: 10,);
          },
          itemCount: cardprovider.getCardListLength
      ):
      const SizedBox(
        child: Center(
          child: Text(
            "There are no cards yet",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),

    );
  }
}

class CardTile extends StatelessWidget {

  CardModel model;
  BuildContext context;
  int myIndex;
  final VoidCallback onClick;
  var SelectedIndex;


  CardTile({required this.model, required this.context,
    required this.myIndex, required this.SelectedIndex, required this.onClick
  });


  @override
  Widget build(BuildContext context) {
    CardProvider cardprovider = Provider.of<CardProvider>(context);
    final size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        width: size.width,
        height: 278.26,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 33.66),
              width: size.width,
              height: 188.26,
              decoration: BoxDecoration(
                border: SelectedIndex == myIndex? Border.all(color: Colors.blue,width: 3.0,style:
                BorderStyle.solid,strokeAlign: StrokeAlign.inside)
                    :Border.all(color: Colors.white,width: 1.0,style:
                BorderStyle.solid,strokeAlign: StrokeAlign.inside),
                color: const Color(0xff232558),
                borderRadius: BorderRadius.circular(12.99),
                gradient: const LinearGradient(
                  colors: InsuremartColor.blackG,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 79.88),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '••••',
                        style: InsuremartTheme.lightTextTheme.headline1!.copyWith(
                          color: InsuremartColor.white1.withOpacity(.5),
                        ),
                      ),
                      Text(
                        '••••',
                        style: InsuremartTheme.lightTextTheme.headline1!.copyWith(
                          color: InsuremartColor.white1.withOpacity(.5),
                        ),
                      ),
                      Text(
                        '••••',
                        style: InsuremartTheme.lightTextTheme.headline1!.copyWith(
                          color: InsuremartColor.white1.withOpacity(.5),
                        ),
                      ),
                      Text(

                        model.cardNumber.toString().substring(model.cardNumber.toString().length-4),
                        style: InsuremartTheme.lightTextTheme.headline1!.copyWith(
                          color: InsuremartColor.white1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 19.38),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Card Holder',
                        style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                          fontSize: 10,
                          color: InsuremartColor.white1.withOpacity(.5),
                        ),
                      ),
                      Text(
                        'Expires',
                        style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                          fontSize: 10,
                          color: InsuremartColor.white1.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.cardName.toString(),
                        style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: InsuremartColor.white1.withOpacity(.5),
                        ),
                      ),
                      Text(
                        model.cardExp.toString(),
                        style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: InsuremartColor.white1.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(),
                    const SizedBox(width: 30),
                    TextButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            content: Text(
                              "Are you sure you want to delete this card?",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15
                              ),
                            ),
                            actions: [

                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              },
                                  child: Text("cancel",
                                    style: TextStyle(
                                        color: InsuremartTheme.blue1
                                    ),)),
                              TextButton(onPressed: () async {
                                Navigator.pop(context);
                                cardprovider.deleteCard(myIndex);
                              },
                                  child: Text("Ok",
                                    style: TextStyle(
                                        color: InsuremartTheme.blue1
                                    ),)),
                            ],

                          );
                        });
                        ;
                      },
                      child: Text(
                        'Delete Card',
                        style: InsuremartTheme.lightTextTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: InsuremartColor.red1,
                        ),
                      ),
                    )
                  ],
                ),
                // Container(
                //   height: 30,
                //   width: 30,
                //   decoration: BoxDecoration(
                //     color: InsuremartColor.black1.withOpacity(.2),
                //     shape: BoxShape.circle,
                //   ),
                // ),
                SelectedIndex ==myIndex
                    ?const Icon(
                  Icons.check_circle,
                  size: 30,
                  color: InsuremartColor.black1,
                ):Icon(Icons.check_box_outline_blank),
              ],
            )
          ],
        ),
      ),
    );
  }
}
