import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PayPalIntegration extends StatefulWidget {
  @override
  _PayPalIntegrationState createState() => _PayPalIntegrationState();
}

class _PayPalIntegrationState extends State<PayPalIntegration> {
//                                       "AUtXcJG0qu0aBhaVXjeOuvtNoDyh5vzhBsiVHYbptpvSvG3LMyaFrTr0I6jjDEZ3P_5pnRe8cKSzqxrc",
//                                       "EPDGhH8UewwHAkYjAHMU-91_dyLyKo1C0eKDdN8gwctAdR2ZueM4r6LNGf466PSvqRVEMKePV3h2D_0q",
  final String clientId = "AUtXcJG0qu0aBhaVXjeOuvtNoDyh5vzhBsiVHYbptpvSvG3LMyaFrTr0I6jjDEZ3P_5pnRe8cKSzqxrc"; // Replace with your Client ID
  final String secretId = "EPDGhH8UewwHAkYjAHMU-91_dyLyKo1C0eKDdN8gwctAdR2ZueM4r6LNGf466PSvqRVEMKePV3h2D_0q"; // Replace with your Secret ID
  final String paypalUrl = "https://api-m.sandbox.paypal.com"; // Sandbox URL
  final String returnUrl = "https://example.com/success"; // Replace with your success URL
  final String cancelUrl = "https://example.com/cancel"; // Replace with your cancel URL

  String? approvalUrl; // PayPal approval URL
  String? accessToken; // PayPal API access token

  @override
  void initState() {
    super.initState();
    _getAccessToken(); // Fetch the access token on initialization
  }

  Future<void> _getAccessToken() async {
    final response = await http.post(
      Uri.parse("$paypalUrl/v1/oauth2/token"),
      headers: {
        "Accept": "application/json",
        "Accept-Language": "en_US",
        "Authorization":
            "Basic ${base64Encode(utf8.encode('$clientId:$secretId'))}",
      },
      body: {"grant_type": "client_credentials"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        accessToken = data['access_token'];
      });
    } else {
      print("Failed to get access token: ${response.body}");
    }
  }

  Future<void> _createPaymentOrder() async {
    final response = await http.post(
      Uri.parse("$paypalUrl/v2/checkout/orders"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: json.encode({
        "intent": "CAPTURE",
        "purchase_units": [
          {
            "amount": {
              "currency_code": "USD",
              "value": "10.00", // Payment amount
            }
          }
        ],
        "application_context": {
          "return_url": returnUrl,
          "cancel_url": cancelUrl,
        },
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final links = data['links'];
      for (var link in links) {
        if (link['rel'] == 'approve') {
          setState(() {
            approvalUrl = link['href'];
          });
          break;
        }
      }
    } else {
      print("Failed to create payment order: ${response.body}");
    }
  }

  Future<void> _launchPaymentUrl() async {
    if (approvalUrl != null && await canLaunchUrl(Uri.parse(approvalUrl!))) {
      await launchUrl(Uri.parse(approvalUrl!), mode: LaunchMode.externalApplication);
    } else {
      print("Cannot launch URL or Approval URL is null.");
    }
  }

  void _startPayment(BuildContext context) async {
    await _createPaymentOrder();

    if (approvalUrl != null) {
      await _launchPaymentUrl();
    } else {
      print("Approval URL is not available.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PayPal Integration")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _startPayment(context),
          child: Text("Pay with PayPal"),
        ),
      ),
    );
  }
}


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';

// class PayPalIntegrationExample extends StatefulWidget {
//   const PayPalIntegrationExample({super.key});

//   @override
//   _PayPalIntegrationExampleState createState() =>
//       _PayPalIntegrationExampleState();
// }

// class _PayPalIntegrationExampleState extends State<PayPalIntegrationExample> {
//   final String clientId = "YOUR_CLIENT_ID"; // Replace with your Client ID
//   final String secretId = "YOUR_SECRET_ID"; // Replace with your Secret ID
//   final String paypalUrl = "https://api-m.sandbox.paypal.com"; // Sandbox URL

//   String? approvalUrl; // The payment approval URL
//   String? accessToken; // PayPal access token

//   @override
//   void initState() {
//     super.initState();
//     _getAccessToken(); // Fetch the access token on app start
//   }

//   Future<void> _getAccessToken() async {
//     final response = await http.post(
//       Uri.parse("$paypalUrl/v1/oauth2/token"),
//       headers: {
//         "Accept": "application/json",
//         "Accept-Language": "en_US",
//       },
//       body: {
//         "grant_type": "client_credentials",
//       },
//       encoding: Encoding.getByName("utf-8"),
//       credentials: ClientCredentials(clientId, secretId),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         accessToken = data['access_token'];
//       });
//     } else {
//       print("Failed to get access token: ${response.body}");
//     }
//   }

//   Future<void> _createPaymentOrder() async {
//     final response = await http.post(
//       Uri.parse("$paypalUrl/v2/checkout/orders"),
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $accessToken",
//       },
//       body: json.encode({
//         "intent": "CAPTURE",
//         "purchase_units": [
//           {
//             "amount": {
//               "currency_code": "USD",
//               "value": "10.00",
//             }
//           }
//         ],
//         "application_context": {
//           "return_url": "https://your-return-url.com/success",
//           "cancel_url": "https://your-return-url.com/cancel",
//         },
//       }),
//     );

//     if (response.statusCode == 201) {
//       final data = json.decode(response.body);
//       final links = data['links'];
//       for (var link in links) {
//         if (link['rel'] == 'approve') {
//           setState(() {
//             approvalUrl = link['href'];
//           });
//           break;
//         }
//       }
//     } else {
//       print("Failed to create payment order: ${response.body}");
//     }
//   }

//   void _startPayment(BuildContext context) async {
//     await _createPaymentOrder();

//     if (approvalUrl != null) {
//       final result = await showDialog(
//         context: context,
//         builder: (context) => Dialog(
//           insetPadding: const EdgeInsets.all(10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: SizedBox(
//             width: double.infinity,
//             height: 500,
//             child: WebView(
//               initialUrl: approvalUrl,
//               javascriptMode: JavascriptMode.unrestricted,
//               navigationDelegate: (navRequest) {
//                 if (navRequest.url.contains("success")) {
//                   Navigator.of(context).pop("success");
//                 } else if (navRequest.url.contains("cancel")) {
//                   Navigator.of(context).pop("cancel");
//                 }
//                 return NavigationDecision.navigate;
//               },
//             ),
//           ),
//         ),
//       );

//       if (result == "success") {
//         print("Payment successful!");
//         // Capture the payment if necessary
//       } else {
//         print("Payment canceled.");
//       }
//     } else {
//       print("Approval URL is not available.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("PayPal Integration Example")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _startPayment(context),
//           child: const Text("Pay with PayPal"),
//         ),
//       ),
//     );
//   }
// }

// class ClientCredentials extends http.BaseClient {
//   final String username;
//   final String password;

//   ClientCredentials(this.username, this.password);

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     request.headers['Authorization'] =
//         'Basic ${base64Encode(utf8.encode('$username:$password'))}';
//     return request.send();
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

// class PayementGatway extends StatelessWidget {
//   const PayementGatway({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: InkWell(
//             onTap: () => 
//             Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (BuildContext context) => PaypalCheckout(
//                                   sandboxMode: true,
//                                   clientId:
//                                       "AUtXcJG0qu0aBhaVXjeOuvtNoDyh5vzhBsiVHYbptpvSvG3LMyaFrTr0I6jjDEZ3P_5pnRe8cKSzqxrc",
//                                   secretKey:
//                                       "EPDGhH8UewwHAkYjAHMU-91_dyLyKo1C0eKDdN8gwctAdR2ZueM4r6LNGf466PSvqRVEMKePV3h2D_0q",
//                                   returnURL:"https://pub.dev/packages/flutter_paypal/example" ,
//                                   cancelURL: "https://pub.dev/packages/flutter_paypal/example",
//                                   transactions: const [
//                                     {
//                                       "amount": {
//                                         "total": '10.12',
//                                         "currency": "USD",
//                                         "details": {
//                                           "subtotal": '10.12',
//                                           "shipping": '0',
//                                           "shipping_discount": 0
//                                         }
//                                       },
//                                       "description":
//                                           "The payment transaction description.",
//                                       // "payment_options": {
//                                       //   "allowed_payment_method":
//                                       //       "INSTANT_FUNDING_SOURCE"
//                                       // },
//                                       "item_list": {
//                                         "items": [
//                                           {
//                                             "name": "A demo product",
//                                             "quantity": 1,
//                                             "price": '10.12',
//                                             "currency": "USD"
//                                           }
//                                         ],
          
//                                         // shipping address is not required though
//                                         // "shipping_address": {
//                                         //   "recipient_name": "Jane Foster",
//                                         //   "line1": "Travis County",
//                                         //   "line2": "",
//                                         //   "city": "Austin",
//                                         //   "country_code": "US",
//                                         //   "postal_code": "73301",
//                                         //   "phone": "+00000000",
//                                         //   "state": "Texas"
//                                         // },
//                                       }
//                                     }
//                                   ],
//                                   note: "Contact us for any questions on your order.",
//                                   onSuccess: (Map params) async {
//                                     print("onSuccess: $params");
//                                   },
//                                   onError: (error) {
//                                     print("onError: $error");
//                                   },
//                                   onCancel: (params) {
//                                     print('cancelled: $params');
//                                   }),
//                             ),
                            
//                           ),
//                           child:const Text("Confirm your order ?"),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // Future<dynamic>? returntesting() async {
// //    return Container();

// // }
// // Future<dynamic>? canceltesting() async {
// //    return Container();

// // }