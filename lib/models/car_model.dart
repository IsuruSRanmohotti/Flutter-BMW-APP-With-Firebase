import 'package:logger/logger.dart';

class Car {
  String description;
  String id;
  String image;
  String name;
  double price;
  String type;

  Car({
    required this.description,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.type,
  });

  factory Car.fromJson(Map<String, dynamic> map) {
    try {
      return Car(
          description: map["description"],
          id: map["id"],
          image: map["image"],
          name: map["name"],
          price: double.parse(map["price"]),
          type: map["type"]);
    } catch (e) {
      Logger().e(e);
      return Car(
          description: "", id: "", image: "", name: "", price: 0, type: "");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "id": id,
      "image": image,
      "name": name,
      "price": price.toString(),
      "type": type,
    };
  }
}


// Car(
//       description:
//           "The BMW 3 Series is a compact executive car known for its sporty performance and luxurious features. It offers a perfect balance of comfort, handling, and advanced technology.",
//       id: 100,
//       image:
//           "https://firebasestorage.googleapis.com/v0/b/central-province-cities.appspot.com/o/1.webp?alt=media&token=db3db186-1d8b-4e82-b25b-a62ec4cccf72",
//       name: "BMW 3 Series",
//       price: 133000,
//       type: "Sedan",
//     ),
//     Car(
//       description:
//           "The BMW 5 Series is a mid-size luxury sedan that delivers exceptional driving dynamics, cutting-edge technology, and a spacious, well-appointed interior.",
//       id: 200,
//       image:
//           "https://firebasestorage.googleapis.com/v0/b/central-province-cities.appspot.com/o/2.webp?alt=media&token=3b095bde-d7a9-4799-bff6-c6ea13f01b27",
//       name: "BMW 5 Series",
//       price: 120000,
//       type: "Sedan",
//     ),
//     Car(
//       description:
//           "The BMW X3 is a compact luxury SUV that combines versatility with BMW's signature driving experience. It offers ample cargo space, advanced safety features, and strong performance.",
//       id: 300,
//       image:
//           "https://firebasestorage.googleapis.com/v0/b/central-province-cities.appspot.com/o/3.webp?alt=media&token=9e17e86f-8981-400e-bab0-e5bab37910fb",
//       name: "BMW X3",
//       price: 134520,
//       type: "SUV",
//     ),
//     Car(
//       description:
//           "The BMW X5 is a mid-size luxury SUV with a spacious and comfortable interior. It provides a smooth ride, advanced technology, and optional third-row seating for increased versatility.",
//       id: 400,
//       image:
//           "https://firebasestorage.googleapis.com/v0/b/central-province-cities.appspot.com/o/4.webp?alt=media&token=28b0c98a-cb40-4dc2-81b7-ed7b329f9293",
//       name: "BMW X5",
//       price: 145000,
//       type: "SUV",
//     ),
//     Car(
//       description:
//           "The BMW 7 Series is a full-size luxury sedan that offers supreme comfort, state-of-the-art technology, and powerful engines. It represents the pinnacle of BMW's craftsmanship and innovation.",
//       id: 500,
//       image:
//           "https://firebasestorage.googleapis.com/v0/b/central-province-cities.appspot.com/o/5.webp?alt=media&token=cbe75a19-6f91-44a1-aeda-1b31a0663b2c",
//       name: "BMW 7 Series",
//       price: 115000,
//       type: "Sedan",
//     ),
//     Car(
//       description:
//           "The BMW i3 is an all-electric compact car that combines sustainable mobility with BMW's renowned driving dynamics. It features a futuristic design and a spacious, eco-friendly interior.",
//       id: 600,
//       image:
//           "https://firebasestorage.googleapis.com/v0/b/central-province-cities.appspot.com/o/6.webp?alt=media&token=c79a6aef-7fe2-4cef-ac32-ebf5d7bcb16e",
//       name: "BMW i3",
//       price: 120000,
//       type: "Electric",
//     ),
//     Car(
//       description:
//           "The BMW M4 is a high-performance sports coupe that offers exhilarating acceleration, precise handling, and aggressive styling. It is designed for those seeking an adrenaline-filled driving experience.",
//       id: 700,
//       image:
//           "https://firebasestorage.googleapis.com/v0/b/central-province-cities.appspot.com/o/8.webp?alt=media&token=b8ac58f7-0dc5-4b92-9dea-5ba606323d17",
//       name: "BMW M4",
//       price: 150000,
//       type: "Sports Car",
//     ),