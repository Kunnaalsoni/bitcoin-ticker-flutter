import 'dart:convert';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'networking/networkHelper.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String activeCurrency = 'USD';
  String APIUrl = 'https://api.coindesk.com/v1/bpi/currentprice/';
  String data = '232.223';
  void getBTC(String cur) async {
    NetworkHelper object  = NetworkHelper(APIUrl+cur);
    var returnVar = await object.getdata();
    var valInCur = jsonDecode(returnVar)['bpi'][activeCurrency]['rate'];
    print(valInCur);
    setState(() {
      data = valInCur;
    });
  }

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String item in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(item), value: item,);
      dropdownItems.add(newItem);
    }
    return dropdownItems;
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
          Padding(
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
                  '1 BTC = $data $activeCurrency',
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
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: activeCurrency,
                items: getDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    activeCurrency = value;
                    getBTC(value);
                  });
                },
            ),
          ),
        ],
      ),
    );
  }
}
