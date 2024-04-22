import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:morzmusicsite/screens/login_screen.dart';



class orderScreen extends StatefulWidget {
  const orderScreen({super.key});

  @override
  State<orderScreen> createState() => _orderScreenState();
}

class _orderScreenState extends State<orderScreen> {

  TextEditingController total = TextEditingController();
  TextEditingController creditcard = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController customer_id = TextEditingController();

  List<Map<String, dynamic>> list = [];

  Future invoiceData() async {
    var url = "https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/getinvoicedetails.php";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var red = jsonDecode(res.body);

      setState(() {
        list = List<Map<String, dynamic>>.from(red);
       // list.addAll(red);
        _streamController.add(red);
      }
      );

      print(list);
    }
  }


  Future<void> createOrder(String song_id, String invoice_id) async {
    var url = 'https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/createorder.php'; // Replace with your PHP script URL
    var response = await http.post(
      Uri.parse(url),
      body: {
        'song_id': song_id,
        'invoice_id': invoice_id,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success']) {
        // Order created successfully
        print('Order created successfully');
      } else {
        // Error creating order
        print('Error creating order: ${data['error']}');
      }
    } else {
      // Handle HTTP error
      print('HTTP error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  //---------DELETE INVOICE----------

  Future DeleteInvoice(id)async{
    var url ="https://morzmusicsite.000webhostapp.com/morz_musicsite_db/musicsite/deleteinvoice.php";
    var res = await http.post(Uri.parse(url), body:{
      'id': id,
    });

    if(res.statusCode == 200){
      var red = jsonDecode(res.body);

      print(red);
    }
  }

  late StreamController <List<dynamic>> _streamController;
  late Stream <List<dynamic>>_stream;

  @override
  void initState() {
    super.initState();

    setState(() {
      _streamController = StreamController();
      _stream = _streamController.stream;
    });

    invoiceData();
    LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('All Invoices'),

    ),
    body: StreamBuilder<List<dynamic>>(
    stream: _stream,
    builder: (stx, snp) {
    if (!snp.hasData) {
    return Container(
    child: Text("no data"),
    );
    } else if (snp.hasError) {
    return CircularProgressIndicator();
    } else {
    return SingleChildScrollView(
    child: Column(
    children: [
    ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: snp.data!.length,
    itemBuilder: (context, i) {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
                    child: ListTile(
                      visualDensity: VisualDensity(vertical: 4),
                      title: Text("CreditCard:${snp.data![i]['creditcard']}"),
                      // Display firstName and lastName in the title
                      tileColor: Colors.grey.shade300,
                      subtitle: Column( // Use a Column widget to display multiple lines in the subtitle
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date: ${snp.data![i]['date']}"),
                          // Display gender in the first line of the subtitle
                          Text("Total Price: ${snp.data![i]['total']}\$"),
                          // Display country in the second line of the subtitle
                        ],
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Spacer(),
                              IconButton(
                             onPressed: () {
                               DeleteInvoice(list[i]["id"]);
                               invoiceData();
                      },
                              icon: Icon(Icons.delete, color: Colors.red),
                      ),
    ]),
    )
    )
                  )
              );
    }
    )]
    )
    );
  }
  }
    )
    );
  }
}
