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


const appiKey='9273F62A-2C42-4EF7-A54F-CA4E495A06FE';
const coinurl='https://rest.coinapi.io/v1/exchangerate';




class RequestapitogetData{

  Future getDataofcoin(String currency) async{
    Map<String,String> cryotoprices={};

    for(String crpto  in cryptoList)
      {
        http.Response response= await http.get(Uri.parse('$coinurl/$crpto/${currency}?apikey=$appiKey'),);


        if(response.statusCode==200)
        {
          var data=jsonDecode(response.body);

          cryotoprices[crpto] = data['rate'].toStringAsFixed(2);

        }
        else{
          print( response.statusCode);
          throw "problem in loading data";
        }

      }
    return cryotoprices;


  }
}
