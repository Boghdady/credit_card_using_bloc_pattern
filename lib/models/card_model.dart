import 'package:flutter/material.dart';

class CardModel {
  String cardHolderName;
  String cardNumber;
  String cardMonth;
  String cardYear;
  String cardCvv;
  Color cardColor;
  String cardType;

  CardModel(
      {this.cardHolderName,
      this.cardNumber,
      this.cardMonth,
      this.cardYear,
      this.cardCvv,
      this.cardColor,
      this.cardType});

  CardModel.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardNumber = json['cardNumber'];
    cardMonth = json['cardMonth'];
    cardYear = json['cardYear'];
    cardCvv = json['cardCvv'];
    cardColor = json['cardColor'];
    cardType = json['cardType'];
  }
}
