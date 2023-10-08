
// Function to build shimmer loading effect
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 5, // Adjust the number of shimmer items
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.white,
            ),
            subtitle: Container(
              width: double.infinity,
              height: 10.0,
              color: Colors.white,
            ),
          ),
        );
      },
    ),
  );
}