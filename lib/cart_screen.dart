import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_3/api.dart';
import 'package:project_3/cart_model.dart';
import 'package:project_3/cart_provider.dart';
import 'package:project_3/menu.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
//  DBHelper? dbHelper = DBHelper();
  List<String> number = List.generate(5, (int index) => '$index');
  late String _item;
  @override
//  void initState() {
//    super.initState();
//    context.read<CartProvider>().getData();
//  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        centerTitle: true,
        title: Column(
          children: [
            Text("Keranjang", style: TextStyle(fontSize: 20)),
          ],
        ),
        actions: [
          Center(
            child: Badge(
              badgeContent: Consumer<CartProvider>(
                builder: ((context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: TextStyle(color: Colors.white),
                  );
                }),
              ),
              animationDuration: Duration(milliseconds: 300),
              // position: const BadgePosition(start: 30, bottom: 30),
              child: Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot == null ? 0 : snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 254, 254, 254),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 6),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 70.0,
                                                height: 70.0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    '$imgProf${snapshot.data![index].image}',
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 24,
                                              ),
                                              SizedBox(
                                                width: 130,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                          text: 'Name: ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade800,
                                                              fontSize: 16.0),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    '${snapshot.data![index].productName.toString()}\n',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ]),
                                                    ),
                                                    RichText(
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                          text: 'Unit: ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade800,
                                                              fontSize: 16.0),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    '${snapshot.data![index].unitTag.toString()}\n',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ]),
                                                    ),
                                                    RichText(
                                                      maxLines: 1,
                                                      text: TextSpan(
                                                          text: 'Price: ' r"Rp",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade800,
                                                              fontSize: 16.0),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    '${snapshot.data![index].productPrice.toString()}\n',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [Icon(Icons.delete)],
                                              )
                                            ],
                                          ),

                                          // Row(

                                          //   children: [
                                          //     Container(
                                          //       padding: EdgeInsets.only(bottom: 5.0),
                                          //       child: Icon(
                                          //         Icons.star,
                                          //         color: Colors.amber,
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       padding: EdgeInsets.only(
                                          //         right: 10.0,
                                          //       ),
                                          //       child: Text("4.5"),
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        );
                      },
                    ),
                  );
                } else {}
                return Text('data');
              }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Column(
              children: [
                ReusableWidget(
                    title: 'Sub Total',
                    value: r'Rp' + value.getTotalPrice().toStringAsFixed(2))
              ],
            );
          })
          // Row(
          //   children: [
          //     Container(
          //       padding: EdgeInsets.only(left: 20, right: 20),
          //       child: Text("Metode pembayaran"),
          //     ),
          //     DropdownButton(
          //       items: [
          //         DropdownMenuItem(
          //           child: Text('Tunai'),
          //           value: "Tunai",
          //         ),
          //         DropdownMenuItem(
          //           child: Text('Non Tunai'),
          //           value: "Non Tunai",
          //         ),
          //       ],
          //       onChanged: (value) {
          //         Text('data');
          //       },
          //       focusColor: Colors.grey,
          //     )
          //   ],
          // )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Colors.yellow.shade600,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
