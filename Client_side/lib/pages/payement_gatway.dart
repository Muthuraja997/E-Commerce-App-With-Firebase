import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PayPalIntegration extends StatefulWidget {
  const PayPalIntegration({super.key});

  @override
  _PayPalIntegrationState createState() => _PayPalIntegrationState();
}

class _PayPalIntegrationState extends State<PayPalIntegration> {
//                                       "AUtXcJG0qu0aBhaVXjeOuvtNoDyh5vzhBsiVHYbptpvSvG3LMyaFrTr0I6jjDEZ3P_5pnRe8cKSzqxrc",
//                                       "EPDGhH8UewwHAkYjAHMU-91_dyLyKo1C0eKDdN8gwctAdR2ZueM4r6LNGf466PSvqRVEMKePV3h2D_0q",
  final String clientId = "AUtXcJG0qu0aBhaVXjeOuvtNoDyh5vzhBsiVHYbptpvSvG3LMyaFrTr0I6jjDEZ3P_5pnRe8cKSzqxrc"; // Replace with your Client ID
  final String secretId = "EPDGhH8UewwHAkYjAHMU-91_dyLyKo1C0eKDdN8gwctAdR2ZueM4r6LNGf466PSvqRVEMKePV3h2D_0q"; // Replace with your Secret ID
  final String paypalUrl = "https://api-m.sandbox.paypal.com"; // Sandbox URL
  final String returnUrl = "https://www.google.com/"; // Replace with your success URL
  final String cancelUrl = "https://www.google.com/"; // Replace with your cancel URL

  String? approvalUrl; // PayPal approval URL
  String? accessToken; // PayPal API access token

  @override
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
        accessToken = data['access_token'];
    } else {
      print("Failed to get access token: ${response.body}");
    }
    print("get access is completed with access_tocken");
    _startPayment(context);
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

  Future<void> _launchPaymentUrl(bool inapp) async {
    print(approvalUrl);
    if (approvalUrl != null && await canLaunchUrl(Uri.parse(approvalUrl!.toString()))) {
        if(inapp){
             await launchUrl(Uri.parse(approvalUrl!.toString()),mode: LaunchMode.inAppWebView);
        }
        else{
        await launchUrl(Uri.parse(approvalUrl!.toString()), mode: LaunchMode.externalApplication);
        }
    } else {
      print("Cannot launch URL or Approval URL is null.");
    }
  }

  void _startPayment(BuildContext context) async {
    
    await _createPaymentOrder();
    print('payment created with ${approvalUrl.toString()}');


    if (approvalUrl != null) {
        
        await _launchPaymentUrl(false);
    } else {
      print("Approval URL is not available.");
    }
  }
   void _launchURL(Uri uri,bool inapp) async{
    try{
      if(await canLaunchUrl(uri)){
        if(inapp){
          await launchUrl(uri,mode: LaunchMode.inAppWebView);
        }
        else{
          await launchUrl(uri,mode: LaunchMode.externalApplication);
        }
      }
    }
    catch(e){print(e.toString());}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PayPal Integration")),
      body: Center(
            child: ElevatedButton(
              onPressed: () => _getAccessToken(),
              child: const Text("Pay with PayPal"),
            ),
              
          ),
    );
  }
}