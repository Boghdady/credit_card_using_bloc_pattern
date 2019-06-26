import 'package:credit_card_using_bloc_pattern/api/cards_api.dart';
import 'package:credit_card_using_bloc_pattern/helpers/card_colors.dart';
import 'package:credit_card_using_bloc_pattern/models/card_model.dart';
import 'package:rxdart/rxdart.dart';

// bloc using single global instance
class CardListBloc {
  List<CardModel> _cardResults;
  CardsApi cardsApi;

  BehaviorSubject<List<CardModel>> _cardsController =
      BehaviorSubject<List<CardModel>>();

  // Retrieve data from stream
  Stream<List<CardModel>> get cardsStream => _cardsController.stream;

  void getCardsFromApi() async {
    cardsApi = CardsApi();
    _cardResults = List<CardModel>();
    _cardResults = await cardsApi.getCardsData();
    for (var i = 0; i < _cardResults.length; i++) {
      _cardResults[i].cardColor = CardColor.baseColors[i];
    }
    print(_cardResults);
    _cardsController.sink.add(_cardResults);
  }

  // constructor
  CardListBloc() {
    getCardsFromApi();
  }

  void dispose() {
    _cardsController.close();
  }
}

final cardListBloc = CardListBloc();
