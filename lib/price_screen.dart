import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform; //'hide' is used to remove only a file.

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  List<double> rateValues = [];
  int btc, eth, ltc;

  @override
  void initState() {
    super.initState();
    decodeData();
  }

  Future<void> decodeData() async {
    for (var crypto in cryptoList) {
      CoinData coinData = CoinData(crypto, selectedCurrency);
      var rates = await coinData.getCoinRate();
      rateValues.add(rates['rate']);
    }

    setState(() {
      if (rateValues.isEmpty) {
        btc = 0;
        eth = 0;
        ltc = 0;
        return;
      }
      btc = rateValues[0].toInt();
      eth = rateValues[1].toInt();
      ltc = rateValues[2].toInt();
      rateValues.clear();
    });
  }

  void selectcurrency(String selectedCurrency) {}

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (var item in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) async {
        selectedCurrency = value;
        await decodeData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerText = [];
    for (String item in currenciesList) {
      pickerText.add(Text(item));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        decodeData();
      },
      children: pickerText,
    );
  }

  Widget card(int coin, String coinName, String selectedCurrency) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coinName = $coin $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                card(btc, 'BTC', selectedCurrency),
                card(eth, 'ETH', selectedCurrency),
                card(ltc, 'LTC', selectedCurrency),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Expanded(
            flex: 1,
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropDown(),
            ),
          ),
        ],
      ),
    );
  }
}
