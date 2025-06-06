import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/core/components/spaces.dart';
import 'package:rest_api/data/models/response/burung_semua_tersedia_model.dart';
import 'package:rest_api/data/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_bloc_bloc.dart';

class BuyerHomescreen extends StatefulWidget {
  const BuyerHomescreen({super.key});

  @override
  State<BuyerHomescreen> createState() => _BuyerHomescreenState();
}

class _BuyerHomescreenState extends State<BuyerHomescreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetBurungTersediaBlocBloc>().add(
      GetAllBurungTersediaBlocEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        backgroundColor: Colors.white,

        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("konfirmasi"),
                    content: const Text("Apakah anda yakin ingin keluar?"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {},
                        child: const Text("Batal"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () {},
                        child: const Text("Keluar"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GetBurungTersediaBlocBloc>().add(
            GetAllBurungTersediaBlocEvent(),
          );
        },
        child: Column(
          children: [
            const SpaceHeight(10),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Daftar burung tersedia",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SpaceHeight(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "cari burung...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<
                  GetBurungTersediaBlocBloc,
                  GetBurungTersediaBlocState
                >(
                  builder: (context, state) {
                    if (state is GetBurungTersediaLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is GetBurungTersediaError) {
                      return Center(
                        child: Text("Terjadi kesalahan ${state.message}"),
                      );
                    }

                    if (state is GetBurungTersediaLoaded) {
                      final List<DataBurungTersedia> burungList =
                          state.burungTersedia.data;

                      if (burungList.isEmpty) {
                        return const Center(
                          child: Text("Tidak ada burung tersedia"),
                        );
                      }

                      return GridView.builder(
                        itemCount: burungList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 220,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                        itemBuilder: (context, index) {
                          final burung = burungList[index];

                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text("Detail Burung"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("No Ring: ${burung.noRing}"),
                                        Text("Usia: ${burung.usia}"),
                                        Text(
                                          "Jenis Kenari ${burung.jenisKenari}",
                                        ),
                                        Text(
                                          "Jenis Kelamin: ${burung.jenisKelamin}",
                                        ),
                                        Text("Harga: Rp${burung.harga}"),

                                        Text(
                                          "Deskripsi: ${burung.deskripsi.isNotEmpty ? burung.deskripsi : 'Tidak Ada Deskripsi'}",
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text("Tutup"),
                                        onPressed: () {},
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child:
                                        burung.image.isEmpty
                                            ? Image.network(
                                              burung.image,
                                              height: 100,
                                              width: double.infinity,
                                              fit: BoxFit.fitHeight,
                                            )
                                            : Container(
                                              height: 100,
                                              width: double.infinity,
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.image_not_supported,
                                              ),
                                            ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            burung.noRing,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Jenis: ${burung.jenisKenari}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "Kelamin: ${burung.jenisKelamin}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "Harga: ${burung.harga}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Status: ${burung.status}",
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
