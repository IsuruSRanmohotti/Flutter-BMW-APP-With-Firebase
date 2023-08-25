import 'package:carousel_slider/carousel_slider.dart';
import 'package:ce_store/components/custom_text/custom_poppins_text.dart';
import 'package:ce_store/models/car_model.dart';
import 'package:ce_store/providers/admin_provider.dart';
import 'package:ce_store/providers/user_provider.dart';
import 'package:ce_store/screens/product_view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> offers = [
    "https://e0.pxfuel.com/wallpapers/512/999/desktop-wallpaper-transport-landscape-auto-roads-mountains-bmw.jpg",
    "https://i.pinimg.com/736x/56/f0/34/56f034a642d568e1e8f264041c19bff4--nature-landscape-wallpaper.jpg",
    "https://wallpaperaccess.com/full/3364154.jpg",
    "https://www.hdcarwallpapers.com/download/2014_vorsteiner_bmw_e92_m3-1920x1080.jpg",
    "https://c4.wallpaperflare.com/wallpaper/831/669/84/green-bmw-m5-black-landscape-trees-hd-wallpaper-preview.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.menu),
                    Spacer(flex: 1),
                    Icon(Icons.search),
                  ],
                ),
                const CustomPoppinsText(
                  text: "Hello Kamal",
                  fontSize: 22,
                ),
                CustomPoppinsText(
                  text: "Lets Start Shopping..!",
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                  ),
                  items: offers.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(i), fit: BoxFit.cover)),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                    future: Provider.of<AdminProvider>(context, listen: false)
                        .fetchProducts()
                        .then((value) {
                      Provider.of<UserProvider>(context, listen: false)
                          .filterFavouriteItems(value);
                      return value;
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Car> cars = snapshot.data!;
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cars.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  childAspectRatio: 0.9),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetails(car: cars[index])));
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Consumer<UserProvider>(
                                      builder: (context, value, child) {
                                    return Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            onTap: () {
                                              if (value.favItems
                                                  .contains(cars[index].id)) {
                                                value.removeFromFavourite(
                                                    context, cars[index]);
                                              } else {
                                                value.addToFavourite(
                                                    context, cars[index]);
                                              }
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: value.favItems
                                                      .contains(cars[index].id)
                                                  ? Colors.red.shade600
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        Image.network(
                                          cars[index].image,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomPoppinsText(
                                                text: cars[index].name,
                                                fontSize: 12,
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                              CustomPoppinsText(
                                                text: "\$ ${cars[index].price}",
                                                fontSize: 12,
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                                fWeight: FontWeight.w700,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const CircularProgressIndicator();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
