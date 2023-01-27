import 'package:ezenSacco/models/card_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../wrapper.dart';


class MyCard extends StatelessWidget {
  final CardModel card;
  const MyCard({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = new DateFormat('dd/MM').format(DateTime.now());
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 0, 15),
      decoration: BoxDecoration(
        color: card.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            card.title,
                            style: TextStyle(
                                fontSize: width * 0.035,
                              fontFamily: "Muli",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            //style: ApptextStyle.MY_CARD_SUBTITLE,
                          ),
                        ],
                      ),
                      SizedBox(width: width*0.25,),

                      Text(
                        "....",
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              Text(card.number,
                style: TextStyle(
                  //fontFamily: "Muli",
                  color: Colors.white,
                  //fontSize: height * 0.02,
                    fontSize: width * 0.05,
                  fontWeight: FontWeight.bold
                )//ApptextStyle.MY_CARD_SUBTITLE,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                            color: Colors.white70,
                          fontFamily: "Muli",
                            fontSize: width * 0.03
                        ),
                      ),
                      Text(
                        card.name,
                        style: TextStyle(
                            fontSize: width * 0.035,
                          color: Colors.white,
                          fontFamily: "Muli",
                        ),
                        //style: ApptextStyle.MY_CARD_SUBTITLE,
                      ),
                    ],
                  ),
                  SizedBox(width: width * 0.1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "As At",
                        style: TextStyle(
                            color: Colors.white70,
                            fontFamily: "Muli",
                            fontSize: width * 0.03,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            fontSize: width * 0.035,
                          fontFamily: "Muli",
                          color: Colors.white
                        )//ApptextStyle.MY_CARD_SUBTITLE,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}