import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Setup native alert channel
    let controller = window?.rootViewController as! FlutterViewController
    let nativeAlertChannel = FlutterMethodChannel(
      name: "com.lessq/native_alert",
      binaryMessenger: controller.binaryMessenger
    )

    nativeAlertChannel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "showAlert" {
        self?.showNativeAlert(call: call, result: result, controller: controller)
      } else if call.method == "showActionSheet" {
        self?.showNativeActionSheet(call: call, result: result, controller: controller)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func showNativeAlert(call: FlutterMethodCall, result: @escaping FlutterResult, controller: UIViewController) {
    guard let args = call.arguments as? [String: Any],
          let title = args["title"] as? String,
          let message = args["message"] as? String,
          let pauseButton = args["pauseButton"] as? String,
          let cancelButton = args["cancelButton"] as? String else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
      return
    }

    // Create native iOS alert
    let alert = UIAlertController(title: title, message: message.isEmpty ? nil : message, preferredStyle: .alert)

    // Pause button (primary action)
    let pauseAction = UIAlertAction(title: pauseButton, style: .default) { _ in
      result("pause")
    }
    alert.addAction(pauseAction)

    // Cancel button (secondary action) - only add if not empty
    if !cancelButton.isEmpty {
      let cancelAction = UIAlertAction(title: cancelButton, style: .cancel) { _ in
        result("cancel")
      }
      alert.addAction(cancelAction)
    }

    // Present on main thread
    DispatchQueue.main.async {
      controller.present(alert, animated: true, completion: nil)
    }
  }

  private func showNativeActionSheet(call: FlutterMethodCall, result: @escaping FlutterResult, controller: UIViewController) {
    guard let args = call.arguments as? [String: Any],
          let title = args["title"] as? String,
          let message = args["message"] as? String,
          let buttons = args["buttons"] as? [String],
          let cancelButton = args["cancelButton"] as? String else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing required arguments", details: nil))
      return
    }

    // Create native iOS action sheet
    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

    // Add action buttons
    for (index, buttonTitle) in buttons.enumerated() {
      let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
        result(String(index))
      }
      alert.addAction(action)
    }

    // Add cancel button
    let cancelAction = UIAlertAction(title: cancelButton, style: .cancel) { _ in
      result("cancel")
    }
    alert.addAction(cancelAction)

    // Present on main thread
    DispatchQueue.main.async {
      controller.present(alert, animated: true, completion: nil)
    }
  }
}
