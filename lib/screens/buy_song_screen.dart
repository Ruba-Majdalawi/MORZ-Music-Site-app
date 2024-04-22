// buy_song_screen.dart

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:morzmusicsite/models/song.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuySongScreen extends StatelessWidget {
  BuySongScreen({super.key, required this.songDetials});
  Song? songDetials;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Song'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: BuySongForm(songDetails: songDetials!,), // Using a separate widget for buy song form
      ),
    );
  }
}

// Separate widget for buy song form
class BuySongForm extends StatefulWidget {
  final Song songDetails;

  const BuySongForm({super.key, required this.songDetails});

  @override
  _BuySongFormState createState() => _BuySongFormState();
}

class _BuySongFormState extends State<BuySongForm> {
  TextEditingController total = TextEditingController();
  TextEditingController creditcard = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController customer_id = TextEditingController();
  TextEditingController song_id = TextEditingController();
  TextEditingController invoice_id = TextEditingController();

  Future buySong() async {

    // Example of POST request to create an invoice
    var url = 'https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/createinvoice.php';
    var response = await http.post(Uri.parse(url), body: {
      'customer_id': customer_id.text,
      'total': total.text,
      'creditcard': creditcard.text,
      'date': date.text, // Example: Use current date
    });

    // Check the response status code
    if (response.statusCode == 200) {
      // Parse the response body
      var responseData = jsonDecode(response.body);

      // Check if the request was successful
      if (responseData['success']) {
        print('Invoice created successfully');
      } else {
        // Handle error
        print('Error creating invoice: ${responseData['error']}');
      }
    } else {
      // Handle HTTP error
      print('HTTP error ${response.statusCode}: ${response.reasonPhrase}');

    }
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Credit Card Information'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ListTile(
                  visualDensity: VisualDensity(vertical: 4),
                  title: Text("${widget.songDetails.title}"),
                  // Display firstName and lastName in the title
                  tileColor: Colors.grey.shade300,
                  subtitle: Column( // Use a Column widget to display multiple lines in the subtitle
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Type: ${widget.songDetails.type}"),
                      // Display gender in the first line of the subtitle
                      Text("Price: ${widget.songDetails.price} \$ "),
                      // Display country in the second line of the subtitle
                    ],
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Text("${widget.songDetails.title.toString()
                        .substring(0, 2)
                        .toUpperCase()}",),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Number',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: creditcard,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter creditcard number',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'CustomerID',
                      style: TextStyle(fontSize: 16),
                   ),
                    TextFormField(
                      controller: customer_id,
                      decoration: InputDecoration(
                        hintText: 'Enter customerID name',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Invoice Date',
                    //  style: TextStyle(fontSize: 16),
                  ),
                    TextFormField(
                      controller: date,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: 'YY-MM-DD',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Total Price',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: total,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter total song price',
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        buySong();

                        print("${widget.songDetails.title}");
                        print(creditcard.text);
                        print(customer_id.text);
                        print(total.text);
                        print(date.text);

                        // Process the credit card information here

                        Navigator.pop(context);
                      },
                      child: Text('Buy Now'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }


