import 'package:intl/intl.dart';
import 'package:muraita_2_0/src/constants/strings.dart';

/// Currency formatter to be used in the app.
final kCurrencyFormatter =
    NumberFormat.simpleCurrency(name: kPeso, locale: 'en-PH');
