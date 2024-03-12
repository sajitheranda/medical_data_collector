import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class SliderImages{

  List<String> imagePaths = [
    'assets/sliderImage/image1.jpg',
    'assets/sliderImage/image2.jpg',
    'assets/sliderImage/image3.jpg',
    'assets/sliderImage/image4.jpg',
    'assets/sliderImage/image5.jpg'
  ];

  Widget Getslider(){
    return CarouselSlider(
    options: CarouselOptions(
      height:300,
      autoPlay: true,
      enlargeCenterPage: true,
      aspectRatio: 16 / 9,
      viewportFraction: 1,
    ),
    items: imagePaths.map((path) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            //margin: EdgeInsets.symmetric(horizontal: 5),
            child: Image.asset(path, fit: BoxFit.cover),
          );
        },
      );
    }).toList(),
    );

  }


}