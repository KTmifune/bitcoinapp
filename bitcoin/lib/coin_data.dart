import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '4FFE37EF-2F72-43BB-BDC9-734327FFABA0';

// get coin exchange rate
class CoinData {
  // assetIdBase:１レートを見たいコインの種類、assetIdQuote：レート変換後コインの種類
  Future getCoinExchangeRate({String assetIdQuote}) async {
    Map<String, String> ratePrice = {};
    for (String crypto in cryptoList) {
      http.Response response =
          await http.get('$coinAPIURL/$crypto/$assetIdQuote?apikey=$apiKey');

      print('$coinAPIURL/$crypto/$assetIdQuote?apikey=$apiKey');
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        double rate = result['rate'];

        //rate no dainyu
        ratePrice[crypto] = rate.toStringAsFixed(0);
      } else {
        print('status:${response.statusCode}');
      }
    }
    return ratePrice;
  }
}
