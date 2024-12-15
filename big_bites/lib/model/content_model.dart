class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent({
    required this.description,
    required this.image,
    required this.title,
  });
}

List<OnboardingContent> contents = [
  OnboardingContent(
    description: "Discover a curated menu with fresh, delicious meals just for you.",
    image: "assets/images/screen1.png",
    title: "Order from our Best Menu",
  ),
  OnboardingContent(
    description: "Enjoy hassle-free payments with cash or card options.",
    image: "assets/images/screen2.png",
    title: "Convenient Payment Options",
  ),
  OnboardingContent(
    description: "Get your food delivered promptly, ensuring freshness and taste.",
    image: "assets/images/screen3.png",
    title: "Fast Delivery Canteen Service",
  ),
];
