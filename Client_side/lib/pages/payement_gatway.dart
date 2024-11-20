import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class PayementGatway extends StatelessWidget {
  const PayementGatway({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () => 
            Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PaypalCheckout(
                                  sandboxMode: true,
                                  clientId:
                                      "AUtXcJG0qu0aBhaVXjeOuvtNoDyh5vzhBsiVHYbptpvSvG3LMyaFrTr0I6jjDEZ3P_5pnRe8cKSzqxrc",
                                  secretKey:
                                      "EPDGhH8UewwHAkYjAHMU-91_dyLyKo1C0eKDdN8gwctAdR2ZueM4r6LNGf466PSvqRVEMKePV3h2D_0q",
                                  returnURL:"https://pub.dev/packages/flutter_paypal/example" ,
                                  cancelURL: "https://pub.dev/packages/flutter_paypal/example",
                                  transactions: const [
                                    {
                                      "amount": {
                                        "total": '10.12',
                                        "currency": "USD",
                                        "details": {
                                          "subtotal": '10.12',
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description":
                                          "The payment transaction description.",
                                      // "payment_options": {
                                      //   "allowed_payment_method":
                                      //       "INSTANT_FUNDING_SOURCE"
                                      // },
                                      "item_list": {
                                        "items": [
                                          {
                                            "name": "A demo product",
                                            "quantity": 1,
                                            "price": '10.12',
                                            "currency": "USD"
                                          }
                                        ],
          
                                        // shipping address is not required though
                                        // "shipping_address": {
                                        //   "recipient_name": "Jane Foster",
                                        //   "line1": "Travis County",
                                        //   "line2": "",
                                        //   "city": "Austin",
                                        //   "country_code": "US",
                                        //   "postal_code": "73301",
                                        //   "phone": "+00000000",
                                        //   "state": "Texas"
                                        // },
                                      }
                                    }
                                  ],
                                  note: "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    print("onSuccess: $params");
                                  },
                                  onError: (error) {
                                    print("onError: $error");
                                  },
                                  onCancel: (params) {
                                    print('cancelled: $params');
                                  }),
                            ),
                            
                          ),
                          child:const Text("Confirm your order ?"),
          ),
        ),
      ),
    );
  }
}
// Future<dynamic>? returntesting() async {
//    return Container();

// }
// Future<dynamic>? canceltesting() async {
//    return Container();

// }