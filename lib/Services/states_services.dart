import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:tracking_app/Modal/Worldstatesmodal.dart';
import 'package:tracking_app/Services/utils/utils.dart';


class StatesServices{

  Future<Worldstatesmodal> worldstatesapi()async{
     final response=await http.get(Uri.parse(Appurl.worldstatusapi));

     if(response.statusCode==200){
       final data=jsonDecode(response.body.toString());
       return Worldstatesmodal.fromJson(data);
     }
     else{
       throw Exception('Error');
     }
  }
  Future<List<dynamic>> countryapi()async{
    var data;
    final response=await http.get(Uri.parse(Appurl.countrylist));

    if(response.statusCode==200){
       data=jsonDecode(response.body.toString());
      return data;
    }
    else{
      throw Exception('Error');
    }
  }


}