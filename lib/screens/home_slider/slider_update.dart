import 'dart:io';

import 'package:ce_store/providers/home_slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateSlider extends StatefulWidget {
  const UpdateSlider({super.key});

  @override
  State<UpdateSlider> createState() => _UpdateSliderState();
}

class _UpdateSliderState extends State<UpdateSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Slider"),
      ),
      body: Consumer<HomeSliderProvider>(builder: (context, value, child) {
        return Center(
            child: Wrap(
          children: List.generate(
              6,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        value.pickImage(context, index);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: value.sliderImages[index] != ""
                              ? value.sliderImages[index].contains(
                                      "https://firebasestorage.googleapis.com")
                                  ? Image.network(
                                      value.sliderImages[index],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(value.sliderImages[index]),
                                      fit: BoxFit.cover,
                                    )
                              : const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ),
                  )),
        ));
      }),
    );
  }
}
