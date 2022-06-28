import 'package:http/http.dart' ;
import 'dart:convert';
import 'package:intl/intl.dart';

class worldCases{
  var inputCountry;
  var total;
  var active;
  var recovered;
  var deaths;
  var countries = [];
  var formatter = NumberFormat('#,###,000');

  worldCases({this.inputCountry});

  Future getCountryCases() async {
    try {
      Response response = await get(Uri.parse('https://coronavirus-19-api.herokuapp.com/countries/$inputCountry'));
      Map data = jsonDecode(response.body);


      total = formatter.format(data['cases']).replaceAll(',', ' ');
      active = formatter.format(data['active']).replaceAll(',', ' ');
      recovered = formatter.format(data['recovered']).replaceAll(',', ' ');
      deaths = formatter.format(data['deaths']).replaceAll(',', ' ');

    }catch (e) {
      print('Caught Error: $e');
    }
  }

  Future getGlobalCases() async {
    try {
      Response response = await get(Uri.parse('https://coronavirus-19-api.herokuapp.com/all'));
      Map data = jsonDecode(response.body);


      total = formatter.format(data['cases']).replaceAll(',', ' ');
      recovered = formatter.format(data['recovered']).replaceAll(',', ' ');
      deaths = formatter.format(data['deaths']).replaceAll(',', ' ');

    }catch (e) {
      print('Caught Error: $e');
    }
  }

  Future getCountry() async {
    try {
      Response response = await get(Uri.parse('https://coronavirus-19-api.herokuapp.com/countries'));
      List data = jsonDecode(response.body);
      List country_list = [];

      for  (var item in data){
       country_list.add((item['country']));
      }
      country_list.removeAt(0);

      countries = country_list;

    }catch (e) {
      print('Caught Error: $e');
    }
  }




}