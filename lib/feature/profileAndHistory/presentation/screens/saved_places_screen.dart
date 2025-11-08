import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideztohealth/core/extensions/text_extensions.dart';

import '../../../home/controllers/home_controller.dart';
import '../../../home/presentation/widgets/saved_pleaces_single_container.dart';

class SavedPlaceScreen extends StatefulWidget {
  const SavedPlaceScreen({super.key});

  @override
  State<SavedPlaceScreen> createState() => _SavedPlaceScreenState();
}

class _SavedPlaceScreenState extends State<SavedPlaceScreen> {

  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      homeController.getSavedPlaces();
    });
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController){
      return homeController.isLoading 
      ? Center(child: CircularProgressIndicator(),) 
      :SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
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
                ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              homeController.getSavedPlacesResponseModel.data
                                      ?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            final place = homeController
                                .getSavedPlacesResponseModel.data
                                ?[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(SavedPlaceScreen());
                                  },
                                  child: SavedPlaceSingeContainer(
                                    title: place?.name ?? 'Unknown',
                                    subTitle: place?.address ?? 'No Address',
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );


    });
    
    


  }
}
