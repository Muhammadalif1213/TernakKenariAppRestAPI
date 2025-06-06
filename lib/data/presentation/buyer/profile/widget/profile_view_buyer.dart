// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rest_api/data/models/response/buyer/buyer_profile_response_model.dart';

class ProfileViewBuyer extends StatelessWidget {
  final Data profile;
  const ProfileViewBuyer({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nama: ${profile.name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            Text(
              "Alamat: ${profile.address}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            Text(
              "No HP: ${profile.phone}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(onPressed: (){}, child: const Text("Go to Home"))
          ],
        ),
      ),
    );
  }
}
