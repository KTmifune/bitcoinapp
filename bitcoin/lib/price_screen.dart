import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentDropdownItemValue = 'USD';

  List<DropdownMenuItem<String>> getDropdownItem() {
    String item;
    List<DropdownMenuItem<String>> dropDownItemList = [];

    for (int i = 0; i < currenciesList.length; i++) {
      item = currenciesList[i];
      dropDownItemList.add(
        DropdownMenuItem(child: Text(item), value: item),
      );
    }
    return dropDownItemList;
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightGreen,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightGreen,
            child: CupertinoPicker(
                backgroundColor: Colors.lightGreen,
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedIndex) {
                  print(selectedIndex);
                },
                children: [
                  Text('USD'),
                  Text('JPY'),
                  Text('IND'),
                ]),
          ),
        ],
      ),
    );
  }
}

//DropdownButton<String>(
//value: currentDropdownItemValue,
//items: getDropdownItem(),
//onChanged: (newValue) {
//setState(() {
//currentDropdownItemValue = newValue;
//print(newValue);
//});
//},
//)
