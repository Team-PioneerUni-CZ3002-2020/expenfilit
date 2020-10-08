import 'package:flutter/material.dart';

const hghlgtYellow = Color(0xFFF8B525);
const bgYellow = Color(0xFFEBEADF);
const hghlgtBlue = Color(0xFF407BFC);
const graphBlue = Color(0xFF1DA1F2);
const hghlgtRed = Color(0xFFE0245E);
const hghlgtGreen = Color(0xFF109C98);
const themeGreyWhite = Color(0xFFE6ECF0);
const icUnselectGrey = Color(0xFF657786);
const themeDarkBlack = Color(0xFF38444D);
const themeDarkerBlack = Color(0xFF010838);
const themeBlack = Color(0xFF15202B);

Color catColour(String catType) {
  switch (catType) {
    case 'Bank Account':
      return graphBlue;
      break;
    case 'Credit Card':
      return hghlgtRed;
      break;
    case 'Investments':
      return hghlgtYellow;
      break;
    case 'Loans':
      return hghlgtGreen;
      break;
    case 'Cash Wallet':
    case 'Cash':
      return hghlgtBlue;
      break;
    case 'Insurance':
      return icUnselectGrey;
      break;
    default:
      return graphBlue;
  }
}
