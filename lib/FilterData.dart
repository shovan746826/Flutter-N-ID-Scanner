import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FilterData {
  static String getName(var readText) {
    int count = 0;
    bool flag = false;
    String textData = "";

    for (TextBlock block in readText.blocks) {
      print("${block.text}");
      if (block.text.contains("Name")) {
        flag = true;
        count = 0;
      }
      if (count == 2) {
        flag = false;
        count = 0;
      }
      if (flag && count > 0) {
        textData += block.text + " ";
      }
      count++;
    }

    return textData;
  }

  static String getBirth(var readText) {
    String textData = "";
    for (TextBlock block in readText.blocks) {
      print("${block.text}");
      if (block.text.contains("Date of Birth")) {
        textData = block.text;
      }
    }

    return textData;
  }

  static String getNid(var readText) {
    String textData = "";

    for (TextBlock block in readText.blocks) {
      textData=block.text;
      String data=textData;
      data=data.replaceAll(new RegExp(r"\s\b|\b\s"), "");
      try{
        int.parse(data);
        break;
      }catch(ex){

      }
    }

    return "N-ID: $textData";
  }
}
