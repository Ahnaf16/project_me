import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core.dart';

String _prettyJSON(response) {
  final encoder =
      JsonEncoder.withIndent("\x1B[33m  ", (object) => object.toString());
  return encoder.convert(response);
}

logJSON(response, [String name = '']) => log(_prettyJSON(response));
printJSON(response, [String name = '']) => debugPrint(_prettyJSON(response));

class URLHelper {
  static url(String url) async {
    await launchUrl(Uri(scheme: 'https', path: url));
  }

  static call(String number) async {
    if (number.isValidPhone) {
      final parsed = number.startsWith('+88') ? number : '+88$number';
      await launchUrl(
        Uri(scheme: "tel", path: parsed),
      );
    }
  }

  static mail(String mail) async {
    if (mail.isValidEmail) {
      await launchUrl(
        Uri(scheme: "mailto", path: mail),
      );
    }
  }

  static massage(String number) async {
    if (number.isValidPhone) {
      final parsed = number.startsWith('+88') ? number : '+88$number';
      try {
        launchUrl(
          Uri(
            scheme: "sms",
            path: "+88$parsed",
            queryParameters: <String, String>{
              'body': Uri.encodeComponent(''),
            },
          ),
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }
}
