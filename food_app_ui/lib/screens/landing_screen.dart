import 'package:flutter/material.dart';
import 'package:food_app_ui/utils/widget_functions.dart';
import '../../utils/constants.dart';
import 'product_item.dart';
import 'product_page.dart';

const PRODUCT_DATA = [
  {
    "image": "pizza.png",
    "name": "Pizza",
    "rest": "Maritine Star Restaurant",
    "rating": "4.5 (164)",
    "price": 20,
    "currency": "\$",
    "description":
        """pizza, dish of Italian origin consisting of a flattened disk of bread dough topped withsome combination of olive oil, oregano, tomato, olives, mozzarella or other cheese, and many other ingredients, baked quickly—usually, in a commercial setting, using a wood-fired oven heated to a very high temperature—and served hot"""
  },
  {
    "image": "burger.png",
    "name": "Burger",
    "rest": "Maritine Star Restaurant",
    "rating": "4.7 (199)",
    "price": 10,
    "currency": "\$",
    "description":
        """A hamburger (or burger for short) is a food, typically considered a sandwich,consisting of one or more cooked patties—usually ground meat, typically beef—placed inside a sliced bread roll or bun. The patty may be pan fried, grilled, smoked or flame broiled. ... A hamburger topped with cheese is called a cheeseburger."""
  },
  {
    "image": "fries.png",
    "name": "Fries",
    "rest": "Maritine Star Restaurant",
    "rating": "4.2 (101)",
    "price": 10,
    "currency": "\$",
    "description":
        """French fries or simply fries or chips, are pieces of potato that have been deep-fried. ... These are deep-fried, very thin, salted slices of potato that are usually served at room temperature. French fries have numerous variants, from thick-cut to shoestring,crinkle, curly and many other names."""
  },
  {
    "image": "hotdog.png",
    "name": "HotDog",
    "rest": "Maritine Star Restaurant",
    "rating": "3.9 (150)",
    "price": 15,
    "currency": "\$",
    "description":
        """A hot dog (less commonly spelled hotdog) is a food consisting of a grilled orsteamed sausage served in the slit of a partially sliced bun. The term hot dog can also refer to the sausage itself. The sausage used is a wiener (Vienna sausage) or a frankfurter (Frankfurter Würstchen, also just called frank)."""
  },
];

const CATEGORIES = [
  {"image": "salad.png", "name": "Salad"},
  {"image": "fastfood.png", "name": "Fast Food"},
  {"image": "desert.png", "name": "Desert"},
  {"image": "drinks.png", "name": "Drinks"},
  {"image": "drinks.png", "name": "Drinks"},
];

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Widget mainText(BuildContext context) {
    // This widget is the row which has a person's picture and the text: How hungry are you?

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/avatar.png"),
          ),
        ),
        addHorizontalSpace(20),
        Expanded(
          child: Text(
            "How Hungry are you Today?",
            style: textTheme.headline5!.apply(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget searchBar(BuildContext context) {
    // This widget is the search bar below the person's picture

    return TextField(
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white24,
        hintText: "Search Food Items",
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        suffixIcon: Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget productCard(
      BuildContext context, BoxConstraints constraints, dynamic category) {
    // This is the product card in list of product cards right below the search bar

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      width: constraints.maxWidth * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset("assets/images/${category['image']}"),
            addVerticalSpace(10),
            Text(
              "${category['name']}",
              style: textTheme.bodyText2!.apply(color: COLOR_BLACK),
            )
          ],
        ),
      ),
    );
  }

  Widget popularFoodsHeading(BuildContext context) {
    // This widget contains the popular Foods heading

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          "Popular Foods",
          style: textTheme.headline5,
        ),
        const Spacer(),
        Text(
          "View All >",
          style: textTheme.subtitle2!.apply(color: COLOR_ORANGE),
        ),
        addHorizontalSpace(10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        // Set this property to false only if the widgets hidden by the softkeyboard are not important
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // section 1: The green box on top

                    Container(
                      height: constraints.maxHeight * 0.40,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: COLOR_GREEN,
                          ),
                          Image.asset("assets/images/tree_v.png"),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                mainText(context),
                                searchBar(context),
                                addHorizontalSpace(10),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    // section 2: The horizontal list of food cards

                    Container(
                      width: constraints.maxWidth,
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          // margin is added only on 2 sides not on other 2 sides because of scrolling

                          left: 10.0,
                          bottom: 10.0,
                        ),
                        child: Stack(
                          // Since one of the widgets is moving out of the stack, to display it we have to set clipBehaviour to none

                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Some margin by estimate for positioned scrolling list
                                addVerticalSpace(constraints.maxWidth * 0.35),
                                popularFoodsHeading(context),
                                addVerticalSpace(10),
                                // This is the list of product cards at the bottom of the screen
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                    children: PRODUCT_DATA
                                        .map((data) => InkWell(
                                              onTap: () {
                                                // Navigate to product page
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) {
                                                      return ProductPage(
                                                          itemData: data);
                                                    },
                                                  ),
                                                );
                                              },
                                              child: ProductItem(
                                                productData: data,
                                                width:
                                                    constraints.maxWidth * 0.50,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              // This widget is moving out of the stack on top direction
                              top: -constraints.maxWidth * 0.15,
                              left: 0,
                              child: Container(
                                width: constraints.maxWidth,
                                height: constraints.maxWidth * 0.35,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  children: CATEGORIES.map((category) {
                                    return productCard(
                                        context, constraints, category);
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
