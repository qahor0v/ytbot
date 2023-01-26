import 'dart:convert';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'api_services.dart';
import 'constants.dart';

class TelegramBot {
  static Future sendMessage() async {
    final username = (await Telegram(token).getMe()).username;
    var teledart = TeleDart(token, Event(username!));

    teledart.onCommand("start").listen((event) {
      event.reply(
          "Assalomu Alaykum.\nMarhamat, botga YouTube video havolasini yuboring va bot sizga mp3 file qilib beradi.");
    });
    
    
    teledart.onMessage().listen((event) {
      event.reply("Xatolik! Siz YouTube havola Yubormadingiz!");
    });
    
    
    teledart.onUrl().listen((event) {
      if (event.text!.startsWith("https")) {
        print("https bilan boshlanadi");
        event.reply("Iltimos kuting. File yuklanmoqda...");
        APIServices.getData(event.text!).then((value) {
          try {
            final data = jsonDecode(value!);
            print("sending...");
            print(data.toString());
            event.reply('[${data['title']}](${data['link']})', parseMode: "Markdown");
            print("sended");
          }catch (e){
            event.reply("Xatolik! To'g'ri havola yuboring.");
          }
        });
      } else {
        print("ifdan otmadi");
      }
    });

    teledart.start();
  }
}
