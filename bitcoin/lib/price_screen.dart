import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentDropdownItemValue = 'USD';
  Map<String, String> coinValue = {};
  bool isWaiting = false;

  DropdownButton<String> androidDropdown() {
    String item;
    List<DropdownMenuItem<String>> dropDownItemList = [];

    for (int i = 0; i < currenciesList.length; i++) {
      item = currenciesList[i];
      dropDownItemList.add(
        DropdownMenuItem(child: Text(item), value: item),
      );
    }
    return DropdownButton<String>(
      value: currentDropdownItemValue,
      items: dropDownItemList,
      onChanged: (newValue) {
        setState(() {
          currentDropdownItemValue = newValue;
          print(newValue);
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> itemList = [];
    for (String item in currenciesList) {
      itemList.add(Text(item));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightGreen,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          currentDropdownItemValue = currenciesList[selectedIndex];
          getData();
        });
      },
      children: itemList,
    );
  }

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData()
          .getCoinExchangeRate(assetIdQuote: currentDropdownItemValue);
      isWaiting = false;
      setState(() {
        coinValue = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: <Widget>[
              ExchangeCard(
                assetBase: 'BTC',
                assetQuote: currentDropdownItemValue,
                value: isWaiting ? '?' : coinValue['BTC'],
              ),
              ExchangeCard(
                assetBase: 'ETH',
                assetQuote: currentDropdownItemValue,
                value: isWaiting ? '?' : coinValue['ETH'],
              ),
              ExchangeCard(
                assetBase: 'LTC',
                assetQuote: currentDropdownItemValue,
                value: isWaiting ? '?' : coinValue['LTC'],
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightGreen,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class ExchangeCard extends StatelessWidget {
  final String assetBase;
  final String assetQuote;
  final String value;

  ExchangeCard(
      {@required this.assetBase,
      @required this.assetQuote,
      @required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Container(
        width: 500.0,
        child: Card(
          semanticContainer: true,
          color: Colors.lightGreen,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $assetBase = $value $assetQuote',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
