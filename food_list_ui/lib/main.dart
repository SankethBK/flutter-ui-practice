// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'DetailsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF21BFBD),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 40.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list_alt),
                    color: Colors.white),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.restaurant_menu),
                    color: Colors.white)
              ],
            ),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RichText(
              text: const TextSpan(
                text: "Healthy",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                children: [
                  TextSpan(
                    text: " Food",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 30),
                            _buildFoodItem(
                                'assets/plate1.png', 'Salmon bowl', '\$24.00'),
                            _buildFoodItem(
                                'assets/plate2.png', 'Spring bowl', '\$22.00'),
                            _buildFoodItem(
                                'assets/plate3.png', 'Avocado bowl', '\$26.00'),
                            _buildFoodItem(
                                'assets/plate5.png', 'Berry bowl', '\$24.00'),
                            _buildFoodItem(
                                'assets/plate6.png', 'Salmon bowl', '\$24.00'),
                            _buildFoodItem(
                                'assets/plate7.png', 'Spring bowl', '\$22.00'),
                            _buildFoodItem(
                                'assets/plate8.png', 'Avocado bowl', '\$26.00'),
                            _buildFoodItem(
                                'assets/plate9.png', 'Berry bowl', '\$24.00')
                          ],
                        ),
                      ),
                      bottomThreeButtons()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding bottomThreeButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 65.0,
            width: 60.0,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey, style: BorderStyle.solid, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Center(
              child: Icon(Icons.search, color: Colors.black),
            ),
          ),
          Container(
            height: 65.0,
            width: 60.0,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey, style: BorderStyle.solid, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Center(
              child: const Icon(Icons.shopping_basket, color: Colors.black),
            ),
          ),
          Container(
            height: 65.0,
            width: 120.0,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey, style: BorderStyle.solid, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFF1C1428)),
            child: const Center(
                child: const Text('Checkout',
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 15.0))),
          )
        ],
      ),
    );
  }

  Widget _buildFoodItem(String imgPath, String foodName, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsPage(
                  heroTag: imgPath, foodName: foodName, foodPrice: price)));
        },
        child: ListTile(
          leading: Hero(
            tag: imgPath,
            child: Image(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
                height: 60.0,
                width: 60.0),
          ),
          title: Text(
            foodName,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(price),
          trailing: IconButton(
              icon: const Icon(Icons.add),
              color: Colors.black,
              onPressed: () {}),
        ),
      ),
    );
  }
}
