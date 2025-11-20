import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/locaion_controller.dart';
import '../../../controllers/location_picked_controller.dart';
import 'car_selection_map_screen.dart';

class SearchDestinationScreen extends StatefulWidget {
  final ScrollController? scrollController;


  const SearchDestinationScreen({super.key, this.scrollController});

  @override
  State<SearchDestinationScreen> createState() =>
      _SearchDestinationScreenState();
}

class _SearchDestinationScreenState extends State<SearchDestinationScreen> {
  final LocationController locationController = Get.find<LocationController>();
  final AppController appController = Get.find<AppController>();
  final LocationPickedController locationPickedController = LocationPickedController();


  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  bool isSearching = false;
  bool isSearchMode = false;
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        setState(() {
          isSearchMode = true;
        });
      }
    });
  }

  Future<void> performSearch(String query) async {
    locationPickedController.searchChanged(query);
    setState(() {
      isSearching = true;
      isSearchMode = true;
    });

    // Simulate network call or controller logic
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      searchResults = ['$query Street', '$query Avenue', '$query Park'];
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchResults.clear();
      searchTextController.clear();
      isSearchMode = false;
    });
  }

  void handleSearchSubmit(String value) {
    if (value.isNotEmpty) {
      performSearch(value);
      goToMap(value);
    }
  }

  void goToMap(String destination) {
    locationController.selectedAddress.value = destination;
    appController.setCurrentScreen('map');
    Get.to(() => CarSelectionMapScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white),
              Text(
                'Search your destination',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(width: 50),
            ],
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchTextController,
              focusNode: searchFocusNode,
              textInputAction: TextInputAction.search,
              onChanged: (value) => performSearch(value),
              onSubmitted: handleSearchSubmit,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Where are you going?',
                hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.search, color: Colors.white),
                ),
                suffixIcon: searchTextController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: clearSearch,
                      )
                    : null,
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          if (isSearchMode)
            if (isSearching)
              Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: Colors.red),
              )
            else
              Expanded(
                child: ObxValue(
                  (results)=> ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.location_on, color: Colors.white),
                        title: Text(
                          results[index].description,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {

                          // goToMap(results[index]);
                        },
                      );
                    },
                  ),
                  locationPickedController.autoCompliteSuggetion
                ),
              )
          else
            Expanded(
              child: ListView(
                controller: widget.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildPaymentItem(
                    icon: Icons.home,
                    title: 'Home',
                    subtitle: locationController.homeAddress.value,
                    onTap: () => goToMap(locationController.homeAddress.value),
                  ),
                  _buildPaymentItem(
                    icon: Icons.work,
                    title: 'Work',
                    subtitle: locationController.workAddress.value,
                    onTap: () => goToMap(locationController.workAddress.value),
                  ),
                  _buildPaymentItem(
                    icon: Icons.star,
                    title: 'Favorite Location',
                    subtitle: locationController.favoriteAddress.value,
                    onTap: () =>
                        goToMap(locationController.favoriteAddress.value),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white10,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Text("2.7km", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
