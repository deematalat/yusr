import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
class AddressWidget extends StatelessWidget {
  final String ? address;
  final start;
  final end;

  AddressWidget({required this.address, this.start, this.end});

  @override
  Widget build(BuildContext context) {
    final parts = address!.split("، ");
    final mainAddress = parts[0];
    final subAddress = parts.sublist(1).join("، ");

    return InkWell(
      onTap: () {
        _openInGoogleMaps(address!,start,end);
      },
      child: Container(
padding: EdgeInsets.all(5),
        child:
          Text("${mainAddress}${subAddress}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent)),

      ),
    );
  }

  void _openInGoogleMaps(String address,start,end) async {
    MapsLauncher.launchQuery(address);

   // MapsLauncher.launchCoordinates(double.parse(start),double.parse( end));
  }

}
