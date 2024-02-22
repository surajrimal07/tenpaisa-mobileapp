import 'package:paisa/core/utils/string_utils.dart';

String getWalletInfo(int walletValue) {
  switch (walletValue) {
    case 0:
      return 'No wallet';
    case 1:
      return 'Khalti';
    case 2:
      return 'Esewa';
    case 3:
      return 'Khalti and Esewa';
    default:
      return 'Unknown';
  }
}

String decodeInvStyle(int invStyle) {
  switch (invStyle) {
    case 1:
      return StyleStrings.option3;
    case 2:
      return StyleStrings.option4;
    case 3:
      return StyleStrings.option5;
    case 4:
      return StyleStrings.option6;
    default:
      return 'No style';
  }
}
