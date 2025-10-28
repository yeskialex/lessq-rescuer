import 'package:flutter/services.dart';

class NativeAlertService {
  static const MethodChannel _channel = MethodChannel('com.lessq/native_alert');

  /// Shows a native iOS alert with custom title, message, and buttons
  /// Returns 'pause' or 'cancel' based on which button was pressed
  static Future<String?> showWarningAlert({
    required String title,
    required String message,
    String pauseButtonText = 'Pause',
    String cancelButtonText = 'Cancel',
  }) async {
    try {
      final String? result = await _channel.invokeMethod('showAlert', {
        'title': title,
        'message': message,
        'pauseButton': pauseButtonText,
        'cancelButton': cancelButtonText,
      });
      return result;
    } on PlatformException catch (e) {
      print('Failed to show native alert: ${e.message}');
      return null;
    }
  }

  /// Shows a native iOS action sheet with multiple buttons
  /// Returns the index of the button pressed as a string ('0', '1', '2', etc.)
  /// or 'cancel' if the cancel button was pressed
  static Future<String?> showActionSheet({
    required String title,
    required String message,
    required List<String> buttons,
    String cancelButtonText = 'Cancel',
  }) async {
    try {
      final String? result = await _channel.invokeMethod('showActionSheet', {
        'title': title,
        'message': message,
        'buttons': buttons,
        'cancelButton': cancelButtonText,
      });
      return result;
    } on PlatformException catch (e) {
      print('Failed to show native action sheet: ${e.message}');
      return null;
    }
  }
}
