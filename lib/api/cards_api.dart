import 'dart:convert';

import 'package:credit_card_using_bloc_pattern/models/card_model.dart';
import 'package:flutter/services.dart';

class CardsApi {
  List<CardModel> _cardResult;

  Future<List<CardModel>> getCardsData() async {
    var initialCards = await rootBundle.loadString('data/initialData.json');
    var decodedJson = jsonDecode(initialCards);
    var jsonData = decodedJson['cardResults'];
    if (jsonData != null) {
      _cardResult = new List<CardModel>();
      jsonData.forEach((card) {
        _cardResult.add(new CardModel.fromJson(card));
      });
    }

    return _cardResult;
  }
}
