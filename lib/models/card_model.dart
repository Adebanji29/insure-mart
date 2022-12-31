import 'package:flutter/material.dart';

class CCard {
  final String cardType;
  final String cardName;
  final String cardNumber;
  final String cardExp;
  final String cardCVV;
  final Color color;
  final bool selected;

  const CCard({
    required this.cardType,
    required this.cardName,
    required this.cardNumber,
    required this.cardCVV,
    required this.cardExp,
    required this.color,
    this.selected = false,
  });
}
