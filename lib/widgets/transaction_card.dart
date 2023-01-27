import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/models/transactions_data.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../wrapper.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 2),
      child: Row(
        children: <Widget>[
          Container(
            height: height * 0.1,
            width: width *0.2,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor4,
                    blurRadius: 24,
                    offset: Offset(0, kSpacingUnit),
                  )
                ]),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/${this.transaction.logo}.svg',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: 'Muli'),
                  children: [
                    TextSpan(
                      text: '${this.transaction.title}\n\n',
                      style: TextStyle(
                        color: Colors.black54,
                          fontSize: width * 0.04,
                        fontWeight: FontWeight.bold
                      )
                    ),

                    TextSpan(
                      text: this.transaction.description,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontFamily: "Muli"
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: TextStyle(fontFamily: 'Muli'),
              children: [
                TextSpan(
                  text:
                  '${this.transaction.value.isNegative ? '(' : ''} ${formatCurrency(this.transaction.value.abs())} ${this.transaction.value.isNegative ? ')' : ''}\n\n',
                  style:TextStyle(
                    //fontWeight: FontWeight.w600,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Muli",
                    fontSize: width * 0.045,
                    color: this.transaction.value.isNegative
                        ? Colors.redAccent
                        : Colors.green,
                  ),
                ),
                TextSpan(
                  text: this.transaction.date,
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "Muli",
                        fontSize: width * 0.025,
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
