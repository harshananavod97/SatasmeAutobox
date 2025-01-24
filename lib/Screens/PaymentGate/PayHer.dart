// import 'package:flutter/material.dart';
// import 'package:newautobox/Api%20Service/ApiService.dart';
// import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

// class PaymentHandler {
//   final BuildContext context;

//   PaymentHandler(this.context);

//   void _showAlert(String title, String msg) {
//     // Set up the button
//     Widget okButton = TextButton(
//       child: Text("OK"),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );

//     // Set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(msg),
//       actions: [
//         okButton,
//       ],
//     );

//     // Show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   void startOneTimePayment({
//     required double amount,
//     required String orderId,
//     required String items,
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String phone,
//     required String address,
//     required String city,
//     required String country,
//     required bool istop,
//     required int userid,
//     required int packageId,
//   }) {
//     Map<String, dynamic> paymentObject = {
//       "sandbox": false, // Set to true for sandbox mode
//       "merchant_id": "1224415", // Replace with your Merchant ID
//       "notify_url":
//           "https://satasmephp.shop/Web/Vendor/ads", // Replace with your notify URL
//       "order_id": orderId,
//       "items": items,
//       "amount": amount,
//       "currency": "LKR",
//       "first_name": firstName,
//       "last_name": lastName,
//       "email": email,
//       "phone": phone,
//       "address": address,
//       "city": city,
//       "country": country,
//     };

//     PayHere.startPayment(paymentObject, (paymentId) {
//       print("One Time Payment Success. Payment Id: $paymentId");

//       _showAlert("Payment Success!", "Payment Id: $paymentId");
//       istop
//           ? ApiService().BuyNormalAddPackage(userid, packageId, context)
//           : ApiService().BuyNormalAddPackage(userid, packageId, context);
//     }, (error) {
//       print("One Time Payment Failed. Error: $error");
//       _showAlert("Payment Failed", "$error");
//     }, () {
//       print("One Time Payment Dismissed");
//       _showAlert("Payment Dismissed", "");
//       _showAlert("Payment Dismissed", "");
//     });
//   }
// }
