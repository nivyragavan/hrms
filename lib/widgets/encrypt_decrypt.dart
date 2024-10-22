import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_sodium/flutter_sodium.dart';

class LibSodiumAlgorithm {
  final keyHex =
      "20f52cbd78033da9905ecb7891e7c9b8dad0c79b30177ffe87cec59ab337d783";
  final nonceHex = "5c27c449e7531dd3e439cb7fb14a253675328661555ed8f6";
  encryptionMessage(Map<String, dynamic> data) {
    String _encryptedMessage = '';
    final key = Sodium.hex2bin(keyHex);
    final nonce = Sodium.hex2bin(nonceHex);
    final message = json.encode(data);

    final encrypted = Sodium.cryptoSecretboxEasy(
        Uint8List.fromList(utf8.encode(message)), nonce, key);

    _encryptedMessage = Sodium.bin2hex(encrypted);
    return _encryptedMessage;
  }
}
