import 'dart:convert';
import 'package:cryptonite/modal/coinmodal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/coincard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<List<Coin>> fetchcoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = jsonDecode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    fetchcoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Center(
      //     child: Text(
      //       'CRYPTONITE',
      //       style: TextStyle(
      //         color: Colors.grey[900],
      //         fontSize: 25,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      // ),
      // body: 
      // Column(
      //   mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     CoinCard(
      //         name: 'Bitcoin',
      //         symbol: 'btc',
      //         imageUrl:
      //             'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
      //         price: 16563.44,
      //         change: -364.61,
      //         changePercentage: -2.15),
      //     CoinCard(
      //         name: 'Ethereumn',
      //         symbol: 'eth',
      //         imageUrl:
      //             'https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880',
      //         price: 1231.04,
      //         change: -41.47,
      //         changePercentage: -3.25),
      //   ],
      // ),

      // SizedBox(
      //   height: MediaQuery.of(context).devicePixelRatio,
      //   // width: MediaQuery.of(context).devicePixelRatio,
      //   child: Column(
      //     children: [
      //       CoinCard(
      //         name: 'Bitcoin',
      //         symbol: 'btc',
      //         imageUrl: '',
      //         price: 16562,
      //         change: -153.5,
      //         changePercentage: -2.15,
      //       )
      //     ],
      //   ),
      // ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: coinList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
      return CoinCard(
        name: coinList[index].name,
        symbol: coinList[index].symbol,
        imageUrl: coinList[index].imageUrl,
        price: coinList[index].price.toDouble(),
        change: coinList[index].change.toDouble(),
        changePercentage: coinList[index].changePercentage.toDouble(),
      );
          },
        ),
    );
  }
}
