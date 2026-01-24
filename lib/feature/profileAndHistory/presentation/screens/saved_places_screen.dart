import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideztohealth/core/extensions/text_extensions.dart';
import 'package:rideztohealth/core/widgets/shimmer/shimmer_skeleton.dart';

import '../../../home/controllers/home_controller.dart';
import '../../../home/presentation/widgets/saved_pleaces_single_container.dart';

class SavedPlaceScreen extends StatefulWidget {
  const SavedPlaceScreen({super.key});

  @override
  State<SavedPlaceScreen> createState() => _SavedPlaceScreenState();
}

class _SavedPlaceScreenState extends State<SavedPlaceScreen> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getSavedPlaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(builder: (homeController) {
      return homeController.isLoading
          ? _buildLoadingShimmer(context)
          : SafeArea(
              bottom: false,
              child: Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    color: Colors.white,
                    onPressed: () => Get.back(),
                  ),
                  centerTitle: false,
                  title: 'Your Saved Places'.text22White(),
                  backgroundColor: Colors.transparent,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),

                        // ✅ Smart Saved Places Display
                        Builder(builder: (context) {
                          final savedPlaces =
                              homeController.getSavedPlacesResponseModel.data ??
                                  [];

                          // No saved places
                          if (savedPlaces.isEmpty) {
                            return Center(
                              child: Padding(
                                padding:
                                     EdgeInsets.symmetric(vertical: size.height * 0.3),
                                child:
                                    'No saved places yet.'.text16White500(),
                              ),
                            );
                          }

                          // Show max 2 items
                          final itemCount = savedPlaces.length > 2
                              ? 2
                              : savedPlaces.length;

                          return ListView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              final place = savedPlaces[index];
                              return Column(
                                children: [
                                  SavedPlaceSingeContainer(
                                    title: place.name ?? 'Unknown',
                                    subTitle: place.address ?? 'No Address',
                                    isShowDeleteButton: true,
                                    placeId: place.id.toString(),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
                          );
                        }),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }

  Widget _buildLoadingShimmer(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Get.back(),
          ),
          centerTitle: false,
          title: const ShimmerLine(width: 160, height: 18),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              SizedBox(height: 16),
              ShimmerBox(width: double.infinity, height: 70),
              SizedBox(height: 16),
              ShimmerBox(width: double.infinity, height: 70),
              SizedBox(height: 16),
              ShimmerBox(width: double.infinity, height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
