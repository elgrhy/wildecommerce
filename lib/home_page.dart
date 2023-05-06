import 'package:commerce/constants.dart';
import 'package:commerce/demo.dart';
import 'package:commerce/restaurant_info_medium_card.dart';
import 'package:commerce/section_title.dart';
import 'package:flutter/material.dart';
import 'image_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String address = 'add adress here';
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Column(
              children: [
                Text(
                  'Delivery to'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.green),
                ),
                Text(
                  _addressController.text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _showAddressDialog();
                },
                child: const Text(
                  'Change',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
            ],
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: ImageCarousel(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Fresh Nuts',
                press: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  demoMediumCardData.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: RestaurantInfoMediumCard(
                      title: demoMediumCardData[index]['name'],
                      image: demoMediumCardData[index]['image'],
                      popular: demoMediumCardData[index]['popular'],
                      quantity: demoMediumCardData[index]['quantity'],
                      rating: demoMediumCardData[index]['rating'],
                      press: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController newAddressController =
            TextEditingController(text: address);
        const inputDecoration = InputDecoration(
          labelText: "New Address",
          hintText: "Apartment No., Building Name, Area, City, Country",
        );
        return AlertDialog(
          title: const Text("Change Address"),
          content: TextFormField(
            controller: newAddressController,
            decoration: inputDecoration,
            onSaved: (value) {
              setState(() {
                newAddressController.text = value!;
              });
            },
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  address = newAddressController.text;
                  _addressController.text = address;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


class IndicatorDot extends StatelessWidget {
  const IndicatorDot({
    super.key,
    required this.isActive,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white38,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
