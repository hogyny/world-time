import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //time location
  String time; //time in current location
  String flag; //flag
  String url; //api url location
  bool isDayTime; //true or false if daytime or not;


  WorldTime ({this.location, this.flag, this.url});

  Future <void> getTime() async {
    try {
      //make response
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      // print(datetime);
      // print(offset);

      //create Datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time properties
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false; //if statement
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('error in location: $e');
      time = 'could not locate time';
    }
  }

}

