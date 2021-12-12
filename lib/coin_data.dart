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

const apiKey = ''; //Enter an API key from coin API.
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
