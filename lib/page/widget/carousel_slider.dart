import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliders extends StatefulWidget {
  const CarouselSliders({required key}) : super(key: key);

  @override
  State<CarouselSliders> createState() => _CarouselSlidersState();
}

class _CarouselSlidersState extends State<CarouselSliders> {

  final List<String> images = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
  ];

  List<Widget> generateImagesTiles() {
    return images
        .map((element) => ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(
        element,
        fit: BoxFit.cover,
      ),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: generateImagesTiles(),
      options: CarouselOptions(
        enlargeCenterPage: true,
      ),
    );
  }
}
