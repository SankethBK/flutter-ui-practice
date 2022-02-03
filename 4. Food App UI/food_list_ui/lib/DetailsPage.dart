import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String heroTag;
  final String foodName;
  final String foodPrice;

  DetailsPage(
      {required this.heroTag, required this.foodName, required this.foodPrice});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var selectedCard = 'WEIGHT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF7A9BEE),
        body: SingleChildScrollView(
          child: Column(
            children: [
              appBar(context),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 107,
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 50,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(75.0),
                              topRight: Radius.circular(75.0)),
                        ),
                        // We want rest of the widgets below the image to be in natural flow.
                        // We don't want to set set them usign Positioned because that will mean it gets complex to get the look right on all devices

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.55,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: widget.foodName.split(" ")[0],
                                    style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 25.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text:
                                            " " + widget.foodName.split(" ")[1],
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 25.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                              ),
                              const SizedBox(height: 20.0),
                              priceAndItemsButton(),
                              const SizedBox(height: 20.0),
                              Container(
                                height: 150.0,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    _buildInfoCard('WEIGHT', '300', 'G'),
                                    const SizedBox(width: 10.0),
                                    _buildInfoCard('CALORIES', '267', 'CAL'),
                                    const SizedBox(width: 10.0),
                                    _buildInfoCard('VITAMINS', 'A, B6', 'VIT'),
                                    const SizedBox(width: 10.0),
                                    _buildInfoCard('AVAIL', 'NO', 'AV')
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(25.0),
                                        bottomRight: Radius.circular(25.0),
                                      ),
                                      color: Colors.black),
                                  height: 50.0,
                                  child: const Center(
                                    child: Text(
                                      '\$52.00',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: MediaQuery.of(context).size.width * 0.45 / 2,
                      child: Hero(
                        tag: widget.heroTag,
                        child: Image.asset(
                          widget.heroTag,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: MediaQuery.of(context).size.width * 0.55,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Row priceAndItemsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(widget.foodPrice,
            style: const TextStyle(
                fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.grey)),
        Container(height: 25.0, color: Colors.grey, width: 1.0),
        Container(
          width: 125.0,
          height: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.0),
              color: const Color(0xFF7A9BEE)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: const Color(0xFF7A9BEE)),
                  child: const Center(
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
              const Text('2',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 15.0)),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Color(0xFF7A9BEE),
                      size: 20.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Padding appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 60.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            // iconSize: 25,
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          const Text('Details',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle);
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: cardTitle == selectedCard
                  ? const Color(0xFF7A9BEE)
                  : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 100.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(cardTitle,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: cardTitle == selectedCard
                              ? Colors.white
                              : Colors.grey.withOpacity(0.7),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(info,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.0,
                                color: cardTitle == selectedCard
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text(unit,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12.0,
                              color: cardTitle == selectedCard
                                  ? Colors.white
                                  : Colors.black,
                            ))
                      ],
                    ),
                  )
                ])));
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}
