import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechToTextController {
  SpeechToText speech = SpeechToText();
  bool isAvailable = false;
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerCategory = TextEditingController();

  ValueNotifier<String> text = ValueNotifier<String>('');
  ValueNotifier<bool> isListening = ValueNotifier<bool>(false);

  void init() async {
    isAvailable = await speech.initialize(onStatus: onStatus, onError: onError);
  }

  startListening() async {
    if (isAvailable) {
      speech.listen(onResult: resultListener, partialResults: true);
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  stopListening() async {
    speech.stop();
  }

  void onStatus(String status) {
    if (status == 'notAvailable' ||
        status == 'done' ||
        status == 'notListening') {
      isListening.value = false;
    } else {
      isListening.value = true;
    }
  }

  void onError(SpeechRecognitionError errorNotification) {
    print(errorNotification);
  }

  resultListener(SpeechRecognitionResult result) {
    text.value = result.recognizedWords;
    if (text.value.toLowerCase().contains('nome')) {
      controllerName.text = text.value.replaceAll('nome', '');

    }
    if (text.value.toLowerCase().contains('preço')) {
      controllerPrice.text = text.value.replaceAll('preço', '');
    }
    if (text.value.toLowerCase().contains('categoria')) {
      controllerCategory.text =
          text.value.replaceAll('categoria', '');
    }
  }
}
