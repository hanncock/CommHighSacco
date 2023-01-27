import 'package:flutter/cupertino.dart';

class CardModel {
  final String title;
  final String number;
  final String name;
  final String expiry;
  final String background;
  final String route;
  final Color cardColor;

  CardModel(
      {required this.title,
        required this.number,
        required this.name,
        required this.expiry,
        required this.background,
        required this.route,
        required this.cardColor,
      });
}

//      number: 'number',
//      name: 'Outstanding Loan Balance',
//      expiry: '06/22',
//      background: 'assets/images/card_bg_alt.png',
//      route: '/loans',
// import 'package:ezen_sacco/constants/color_constants.dart';
// import 'package:flutter/material.dart';
//
// class CardModel{
//   String cardHoldername;
//   String cardNumber;
//   String expDate;
//   String cvv;
//   Color cardColor;
//
//   CardModel({
//     required this.cardHoldername,
//     required this.cardNumber,
//     required this.cvv,
//     required this.expDate,
//     required this.cardColor
//   });
  // List<CardModel> myCards = [
  //   CardModel(
  //     cardHoldername: 'John Doe',
  //     cardNumber: '**** *** ****',
  //     cvv: '***4',
  //     expDate: '12/02',
  //     cardColor: kPrimaryColor,
  //   ),
  //   CardModel(
  //     cardHoldername: 'John Doe',
  //     cardNumber: '**** *** ****',
  //     cvv: '***4',
  //     expDate: '12/02',
  //     cardColor: kSecondaryColor,
  //   ),
  //   CardModel(
  //     cardHoldername: 'John Doe',
  //     cardNumber: '**** *** ****',
  //     cvv: '***4',
  //     expDate: '12/02',
  //     cardColor: kPrimaryColor,
  //   ),
  //   CardModel(
  //     cardHoldername: 'John Doe',
  //     cardNumber: '**** *** ****',
  //     cvv: '***4',
  //     expDate: '12/02',
  //     cardColor: kSecondaryColor,
  //   ),
  // ].toList();

//}