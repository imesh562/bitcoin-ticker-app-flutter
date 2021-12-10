import 'package:bitcoin_ticker/networking.dart';

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

const apiKey = '8038C4E6-F9E9-4D94-87D3-4EE8ACB6FA75';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  final String from, to;
  CoinData(this.from, this.to);
  Future<dynamic> getCoinRate() async {
    NetworkHelper rates = NetworkHelper('$coinAPIURL/$from/$to?apikey=$apiKey');
    var coinData = await rates.getData();
    return coinData;
  }
}
