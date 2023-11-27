import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/model/asset_model.dart';
import 'package:paisa/utils/icons_utils.dart';

// class AssetList extends StatelessWidget {
//   const AssetList({
//     super.key,
//     required this.firstitem,
//     required this.seconditem,
//     required this.thirditem,
//     required this.assetList,
//   });

//   final List<Asset> assetList;
//   final firstitem;
//   final seconditem;
//   final thirditem;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: assetList.length,
//       itemBuilder: (context, index) => buildAssetListItem(assetList[index]),
//     );
//   }

//   Widget buildAssetListItem(Asset asset) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.only(top: 12),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.04),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 20,
//                   // Use the appropriate way to get the image for the asset
//                   backgroundImage: AssetImage(Iconss.equityIcon),
//                 ),
//                 const SizedBox(width: 8),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       asset.symbol,
//                       style: GoogleFonts.poppins(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       getPropertyValue(firstitem, asset),
//                       style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   getPropertyValue(seconditem, asset),
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   getPropertyValue(thirditem, asset),
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   String getPropertyValue(String propertyName, Asset asset) {
//     switch (propertyName) {
//       case 'category':
//         return asset.category ?? '';
//       case 'sector':
//         return asset.sector ?? '';
//       case 'eps':
//         return asset.eps ?? '';
//       case 'bookvalue':
//         return asset.bookvalue ?? '';
//       case 'pe':
//         return asset.pe ?? '';
//       case 'percentchange':
//         return asset.percentchange ?? '';
//       case 'ltp':
//         return asset.ltp ?? '';
//       case 'unit':
//         return asset.unit ?? '';
//       case 'totaltradedquantity':
//         return asset.totaltradedquantity ?? '';
//       case 'previousclose':
//         return asset.previousclose ?? '';
//       case 'turnover':
//         return asset.turnover ?? '';
//       case 'name':
//         return getShortenedName(asset.name);
//       default:
//         return '';
//     }
//   }

//   String getShortenedName(String fullName) {
//     List<String> words = fullName.split(' ');
//     return words.length > 2 ? words.sublist(0, 2).join(' ') : fullName;
//   }
// }

class AssetList extends StatelessWidget {
  const AssetList({
    super.key,
    required this.firstitem,
    required this.seconditem,
    required this.thirditem,
    required this.assetList,
    this.trendingList,
  });

  final List<Asset> assetList;
  final List<Asset>? trendingList;
  final firstitem;
  final seconditem;
  final thirditem;

  @override
  Widget build(BuildContext context) {
    List<Asset> displayList = trendingList ?? assetList;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayList.length,
      itemBuilder: (context, index) => buildAssetListItem(
          displayList[index], firstitem, seconditem, thirditem),
    );
  }

  Widget buildAssetListItem(Asset asset, firstitem, seconditem, thirditem) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  // Use the appropriate way to get the image for the asset
                  backgroundImage: AssetImage(Iconss.equityIcon),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.symbol,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      getPropertyValue(firstitem, asset),
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  getPropertyValue(seconditem, asset),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  getPropertyValue(thirditem, asset),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getPropertyValue(String propertyName, Asset asset) {
    switch (propertyName) {
      case 'category':
        return asset.category ?? '';
      case 'sector':
        return asset.sector ?? '';
      case 'eps':
        return asset.eps ?? '';
      case 'bookvalue':
        return asset.bookvalue ?? '';
      case 'pe':
        return asset.pe ?? '';
      case 'percentchange':
        return asset.percentchange ?? '';
      case 'ltp':
        return asset.ltp ?? '';
      case 'unit':
        return asset.unit ?? '';
      case 'totaltradedquantity':
        return asset.totaltradedquantity ?? '';
      case 'previousclose':
        return asset.previousclose ?? '';
      case 'turnover':
        return asset.turnover ?? '';
      case 'name':
        return getShortenedName(asset.name);
      default:
        return '';
    }
  }

  String getShortenedName(String fullName) {
    List<String> words = fullName.split(' ');
    return words.length > 2 ? words.sublist(0, 2).join(' ') : fullName;
  }
}
