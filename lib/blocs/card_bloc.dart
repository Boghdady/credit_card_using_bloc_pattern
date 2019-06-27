import 'dart:async';
import 'package:credit_card_using_bloc_pattern/helpers/card_colors.dart';
import 'package:credit_card_using_bloc_pattern/models/card_color_model.dart';
import 'package:credit_card_using_bloc_pattern/models/card_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:credit_card_using_bloc_pattern/services/validator_mixin.dart';

import 'bloc_provider.dart';
import 'card_list_bloc.dart';

class CardBloc with Validators implements BlocBase {
  // define stream controller
  BehaviorSubject<String> _cardHolderName = BehaviorSubject<String>();
  BehaviorSubject<String> _cardNumber = BehaviorSubject<String>();
  BehaviorSubject<String> _cardMonth = BehaviorSubject<String>();
  BehaviorSubject<String> _cardYear = BehaviorSubject<String>();
  BehaviorSubject<String> _cardCvv = BehaviorSubject<String>();
  BehaviorSubject<String> _cardType = BehaviorSubject<String>();
  BehaviorSubject<int> _cardColorIndexSelected = BehaviorSubject<int>();

  final _cardsColors = BehaviorSubject<List<CardColorModel>>();

  // add data to stream
  Function(String) get changeCardHoldName => _cardHolderName.sink.add;
  Function(String) get changeCardNumber => _cardNumber.sink.add;
  Function(String) get changeCardMonth => _cardMonth.sink.add;
  Function(String) get changeCardYear => _cardYear.sink.add;
  Function(String) get changeCardCvv => _cardCvv.sink.add;
  Function(String) get selectCardType => _cardType.sink.add;

  // Retrieve data from stream
  Stream<String> get cardHolderName =>
      _cardHolderName.stream.transform(validateCardHolderName);
  Stream<String> get cardNumber =>
      _cardNumber.stream.transform(validateCardNumber);
  Stream<String> get cardMonth =>
      _cardMonth.stream.transform(validateCardMonth);
  Stream<String> get cardYear => _cardYear.stream.transform(validateCardYear);
  Stream<String> get cardCvv =>
      _cardCvv.stream.transform(validateCardVerificationValue);
  Stream<String> get cardType => _cardType.stream;
  Stream<int> get cardColorIndexSelected => _cardColorIndexSelected.stream;
  Stream<List<CardColorModel>> get cardColorsList => _cardsColors.stream;

  /*
    take the latest values from (cardHolderName, cardNumber, cardMonth, cardYear, cardCvv )
    and return true if this streams are valid
   */
  Stream<bool> get saveCardValid => Observable.combineLatest5(cardHolderName,
      cardNumber, cardMonth, cardYear, cardCvv, (ch, cn, cm, cy, cv) => true);

  void saveCard() {
    final newCard = CardModel(
        cardHolderName: _cardHolderName.value,
        cardNumber: _cardNumber.value.replaceAll(RegExp(r'\s+\b|\b\s'), ''),
        cardMonth: _cardMonth.value,
        cardYear: _cardYear.value,
        cardCvv: _cardCvv.value,
        cardColor: CardColor.baseColors[_cardColorIndexSelected.value],
        cardType: _cardType.value);

    cardListBloc.addCardToList(newCard);
  }

  void selectCardColor(int colorIndex) {
    CardColor.cardColors.forEach((element) => element.isSelected = false);
    CardColor.cardColors[colorIndex].isSelected = true;
    _cardsColors.sink.add(CardColor.cardColors);
    _cardColorIndexSelected.sink.add(colorIndex);
  }

  @override
  void dispose() {
    _cardHolderName.close();
    _cardNumber.close();
    _cardMonth.close();
    _cardYear.close();
    _cardCvv.close();
    _cardsColors.close();
    _cardColorIndexSelected.close();
    _cardType.close();
  }
}
