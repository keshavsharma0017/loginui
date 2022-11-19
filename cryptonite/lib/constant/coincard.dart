import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final double change;
  final double changePercentage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(5, 3),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-6, -2),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                )
                              ]),
                          height: 60,
                          width: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(imageUrl),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              symbol,
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              price.toString(),
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              change.toDouble() < 0
                                  ? change.toDouble().toString()
                                  : '+${change.toDouble()}',
                              style: TextStyle(
                                color: change.toDouble() < 0
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              changePercentage.toDouble() < 0
                                  ? '${changePercentage.toDouble()}%'
                                  : '+${changePercentage.toDouble()}%',
                              style: TextStyle(
                                color: changePercentage.toDouble() < 0
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// const Text(
//                         'Stocks',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       Text(
//                         'December 3',
//                         style: TextStyle(
//                           color: Colors.grey[500],
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: SizedBox(
//                           height: 50,
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: 'Search',
//                               hintStyle: TextStyle(
//                                 color: Colors.grey[500],
//                               ),
//                               filled: true,
//                               fillColor: Colors.grey[800],
//                               prefix: const Align(
//                                 widthFactor: 1.0,
//                                 heightFactor: 1.0,
//                                 child: Icon(Icons.search),
//                               ),
//                               border: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     width: 0, style: BorderStyle.none),
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(18),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),