import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imageLinks;
  const CarouselImage({super.key, required this.imageLinks});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imageLinks.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: widget.imageLinks.map((link) {
            final isUrl =
                link.startsWith('http://') || link.startsWith('https://');
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: isUrl
                    ? Image.network(link, fit: BoxFit.contain)
                    : Image.file(File(link), fit: BoxFit.contain),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 400,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
        ),

        if (widget.imageLinks.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageLinks.asMap().entries.map((e) {
              return Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(
                    _current == e.key ? 0.9 : 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
