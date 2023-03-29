
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dataRequest.dart';
import 'reuseablecard.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedcurr = 'USD';

  Map<String, String> cryptovalues = {};

  bool iswaiting=false;

  void getdataofcoin() async {
    iswaiting=true;
    try {
      RequestapitogetData crptoprices = RequestapitogetData();
      var data = await crptoprices.getDataofcoin(selectedcurr);
      iswaiting=false;



      setState(() {
        cryptovalues = data;
      });


    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getdataofcoin();
  }

  DropdownButton getDrownmenuAndorid() {
    List<DropdownMenuItem<String>> listofdropmenuitems = [];

    for (String curr in currenciesList) {
      var currency = DropdownMenuItem(
        child: Text(curr),
        value: curr,
      );
      listofdropmenuitems.add(currency);
    }

    return DropdownButton<String>(
        value: selectedcurr,
        items: listofdropmenuitems,
        onChanged: (value) {
          setState(() {
            selectedcurr = value.toString();
             getdataofcoin();
          });
        });
  }

  CupertinoPicker getIOSpicker() {
    List<Text> listofTExt = [];
    for (String curr in currenciesList) {
      listofTExt.add(Text(curr));
    }
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (value) {
          selectedcurr = listofTExt[value].toString();
          getdataofcoin();
        },
        children: listofTExt);
  }

  Column makecards() {
    List<card> cards = [];

    for (int i = 0; i < cryptovalues.length; i++) {
      String coin=cryptoList[i];
      cards.add(
        card(coin: coin,value:iswaiting? '?': (cryptovalues[coin].toString()),currency: selectedcurr,),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,

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
          makecards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? getDrownmenuAndorid() : getIOSpicker(),
          ),
        ],
      ),
    );
  }
}
