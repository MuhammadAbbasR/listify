import 'package:flutter/material.dart';
import '../data/Quote_Data.dart';

import '../models/Quote_Model.dart';

class Quote_ViewModel extends ChangeNotifier {
  List<QuoteModel> _quotes = quotes_data;

  List<QuoteModel> get quotes => _quotes;
}
