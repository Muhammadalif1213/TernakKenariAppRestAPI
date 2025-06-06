import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/data/presentation/buyer/profile/widget/profile_buyer_form.dart';
import 'package:rest_api/data/presentation/buyer/profile/widget/profile_view_buyer.dart';

import 'bloc/profile_buyer_bloc.dart';


class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  @override
  initState() {
    super.initState();
    context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Pembeli")),
      body: BlocListener<ProfileBuyerBloc, ProfileBuyerState>(
        listener: (context, state) {
          if (state is ProfileBuyerAdded) {
            //Refresh profile setelah tambah
            context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile Berhasil ditambahkan")),
            );
          }
        },
        child: BlocBuilder<ProfileBuyerBloc, ProfileBuyerState>(
          builder: (context, state) {
            if (state is ProfileBuyerLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileBuyerLoaded &&
                state.profile.data.name.isNotEmpty) {
              final profile = state.profile.data;
              return ProfileViewBuyer(profile: profile);
            }

            return ProfileBuyerInputForm();
          },
        ),
      ),
    );
  }
}
