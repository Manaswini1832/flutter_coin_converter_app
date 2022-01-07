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

class CoinData {
  Future getCoinData(currencyName) async {
    var conversionRates = [];

    for (String cryptoCurrency in cryptoList) {
      Uri requestURL = Uri.https(
          'rest.coinapi.io',
          '/v1/exchangerate/$cryptoCurrency/$currencyName',
          {'apiKey': 'PASTE-API-KEY-HERE'});

      //5. Make a GET request to the URL and wait for the response.
      http.Response response = await http.get(requestURL);

      //6. Check that the request was successful.
      if (response.statusCode == 200) {
        //7. Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
        var decodedData = jsonDecode(response.body);
        //8. Get the last price of bitcoin with the key 'last'.
        var lastPrice = decodedData['rate'].round().toString();
        //9. Output the lastPrice from the method.
        conversionRates.add(lastPrice);
      } else {
        //10. Handle any errors that occur during the request.
        //Optional: throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }
    return conversionRates;
  }
}
