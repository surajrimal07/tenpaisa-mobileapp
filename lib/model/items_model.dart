class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/images/on_boarding_images/1.png",
    title: "Best app to transform\nsmall investment to big amount",
    subTitle:
        "An investment in knowledge \npays the best interest.\n -Benjamin Franklin",
  ),
  Items(
    img: "assets/images/on_boarding_images/1.png",
    title: "Different Opportunities for your\ndifferent investment needs",
    subTitle:
        "Personalized Investment opportunities\n according to your financial goal",
  ),
  Items(
    img: "assets/images/on_boarding_images/3.png",
    title: "Start early with SIPs,\nand let time work its magic.",
    subTitle:
        "Wide variety of SIP, Mutual funds and \nbonds options available in same app",
  ),
];
