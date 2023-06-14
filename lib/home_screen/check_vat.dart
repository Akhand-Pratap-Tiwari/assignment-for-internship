import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckVAT extends StatefulWidget {
  const CheckVAT({super.key});

  @override
  State<CheckVAT> createState() => _CheckVATState();
}

class VAT {
  final String vatNumber;
  final bool valid;
  final Map<String, dynamic> company;
  final Map<String, dynamic> country;

  const VAT(
      {required this.company,
      required this.country,
      required this.valid,
      required this.vatNumber});

  factory VAT.fromJson(Map<String, dynamic> json) {
    return VAT(
      company: json['company'],
      country: json['country'],
      valid: json['valid'],
      vatNumber: json['vat_number'],
    );
  }
}

class _CheckVATState extends State<CheckVAT> {
  Future<VAT> getVAT({String number = "SE556656688001"}) async {
    final response = await http.get(Uri.parse(
        'https://vat.abstractapi.com/v1/validate/?api_key=e2363219a2ab499d83858612d6732cbc&vat_number=$number'));

    if (response.statusCode == 200) {
      return VAT.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<VAT>? vatDetails;
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            width: size.width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      helperText: 'Press check with empty field\nto see demo',
                      label: Text("Input VAT"),
                    ),
                  ),
                ),
                const SizedBox(height: 50, child: VerticalDivider()),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      if (controller.text == "") {
                        controller.text = "SE556656688001";
                      }
                      vatDetails = getVAT(number: controller.text);
                    });
                  },
                  child: const Text("Check"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 160,),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.black),
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MyCard(vat: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Container();
              },
              future: vatDetails,
            ),
          ),
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final VAT vat;
  const MyCard({super.key, required this.vat});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("VAT Number : ${vat.vatNumber}"),
            Text("Valid : ${vat.valid ? 'Yes' : 'No'}"),
            Text("Company Name : ${vat.company['name']}"),
            Text("Company Address : ${vat.company['address']}"),
            Text("Country Code : ${vat.country['code']}"),
            Text("Country Name : ${vat.country['name']}"),
          ],
        ),
      ],
    );
  }
}
