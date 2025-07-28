import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/locaion_controller.dart';
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
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.location_on, color: Colors.white),
                      title: Text(
                        searchResults[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        goToMap(searchResults[index]);
                      },
                    );
                  },
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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rideztohealth/core/extensions/text_extensions.dart';
// import '../../controllers/app_controller.dart';
// import '../../controllers/locaion_controller.dart';
// import 'map_screen.dart';
// import 'chat_screen.dart';
// import 'payment_screen.dart';

// class SearchDestinationScreen extends StatelessWidget {
//   final ScrollController? scrollController;

//   const SearchDestinationScreen({super.key, this.scrollController});
//   @override
//   Widget build(BuildContext context) {
//     // Use Get.find with fallback initialization
//     final LocationController locationController =
//         Get.find<LocationController>();
//     final FocusNode searchFocusNode = FocusNode();
//     final AppController appController = Get.find<AppController>();
//     final TextEditingController searchTextController = TextEditingController();

//     return Obx(
//       () => SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 BackButton(color: Colors.white),
//                 'Search your destination'.text16White(),
//                 const SizedBox(width: 50),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.all(16),
//               child: TextField(
//                 controller: searchTextController,
//                 focusNode: searchFocusNode,
//                 onChanged: (value) => locationController.searchLocation(value),
//                 onSubmitted: (value) {
//                   if (value.isNotEmpty) {
//                     locationController.searchLocation(value);
//                     // Navigate when submitted from keyboard
//                     appController.setCurrentScreen('map');
//                     Get.to(() => MapScreen());
//                   }
//                 },
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: 'Where are you going?',

//                   hintStyle: TextStyle(color: Colors.white, fontSize: 14),
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 18,
//                       bottom: 16,
//                       left: 16,
//                       right: 16,
//                     ),
//                     child: Image.asset(
//                       "assets/icons/destinationIcon.png",
//                       height: 20,
//                       width: 20,
//                     ),
//                   ),
//                   suffixIcon: searchTextController.text.isNotEmpty
//                       ? IconButton(
//                           icon: Icon(Icons.clear, color: Colors.grey),
//                           onPressed: () {
//                             searchTextController.clear();
//                             locationController.clearSearch();
//                           },
//                         )
//                       : null,
//                   filled: true,
//                   fillColor: Colors.white24,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             if (locationController.isSearching.value)
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child: CircularProgressIndicator(color: Colors.red),
//               ),
//             if (locationController.searchResults.isNotEmpty)
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                   itemCount: locationController.searchResults.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: Icon(Icons.location_on, color: Colors.white),
//                       title: Text(
//                         locationController.searchResults[index],
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onTap: () {
//                         locationController.selectSearchResult(index);
//                         searchTextController.text =
//                             locationController.searchResults[index];
//                       },
//                     );
//                   },
//                 ),
//               ),
//             Expanded(
//               child: ListView(
//                 controller: scrollController,
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 children: [
//                   // _buildPaymentItem(
//                   //   icon: Icons.location_on,
//                   //   title: 'Current Location',
//                   //   subtitle: locationController.pickupAddress.value.isEmpty
//                   //       ? 'Using GPS'
//                   //       : locationController.pickupAddress.value,
//                   //   onTap: () => locationController.getCurrentLocation(),
//                   // ),
//                   _buildPaymentItem(
//                     icon: Icons.access_time,
//                     title: 'Home',
//                     subtitle: locationController.homeAddress.value,
//                     onTap: () => locationController.selectSavedLocation('home'),
//                   ),
//                   _buildPaymentItem(
//                     icon: Icons.access_time,
//                     title: 'Work',
//                     subtitle: locationController.workAddress.value,
//                     onTap: () => locationController.selectSavedLocation('work'),
//                   ),
//                   _buildPaymentItem(
//                     icon: Icons.access_time,
//                     title: 'Favorite Location',
//                     subtitle: locationController.favoriteAddress.value,
//                     onTap: () =>
//                         locationController.selectSavedLocation('favorite'),
//                   ),
//                   SizedBox(height: 20),
//                   //  _buildQuickActionButtons(),
//                 ],
//               ),
//             ),
//             // Container(
//             //   width: double.infinity,
//             //   padding: EdgeInsets.all(16),
//             //   child: ElevatedButton(
//             //     onPressed: appController.isLoading.value
//             //         ? null
//             //         : () {
//             //             appController.setCurrentScreen('map');
//             //             Get.to(() => MapScreen());
//             //           },
//             //     style: ElevatedButton.styleFrom(
//             //       backgroundColor: Colors.red,
//             //       padding: EdgeInsets.symmetric(vertical: 16),
//             //       shape: RoundedRectangleBorder(
//             //         borderRadius: BorderRadius.circular(8),
//             //       ),
//             //     ),
//             //     child: appController.isLoading.value
//             //         ? CircularProgressIndicator(color: Colors.white)
//             //         : Text(
//             //             'Choose car',
//             //             style: TextStyle(
//             //               color: Colors.white,
//             //               fontSize: 16,
//             //               fontWeight: FontWeight.bold,
//             //             ),
//             //           ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentItem({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         // margin: EdgeInsets.only(bottom: 12),
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           // color: Colors.white10,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: Colors.white, size: 24),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     style: TextStyle(color: Colors.grey, fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             "2.7km".text14White(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickActionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildQuickActionButton(
//           icon: Icons.payment,
//           label: 'Payment',
//           onTap: () => Get.to(() => PaymentScreen()),
//         ),
//         _buildQuickActionButton(
//           icon: Icons.chat,
//           label: 'Support',
//           onTap: () => Get.to(() => ChatScreen()),
//         ),
//         _buildQuickActionButton(
//           icon: Icons.history,
//           label: 'History',
//           onTap: () => Get.snackbar('Info', 'History feature coming soon!'),
//         ),
//       ],
//     );
//   }

//   Widget _buildQuickActionButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Color(0xFF34495E),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: Colors.white, size: 24),
//             SizedBox(height: 4),
//             Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }
// }
