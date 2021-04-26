// class OnBoarding {
//   String image;
//   String description;

//   OnBoarding({this.image, this.description});
// }

// class OnBoardingList {
//   List<OnBoarding> _list;

//   List<OnBoarding> get list => _list;

//   OnBoardingList() {
//     _list = [
//       new OnBoarding(
//           image: 'img/onboarding0.png',
//           description:
//               'Don\'t cry because it\'s over, smile because it happened.'),
//       new OnBoarding(
//           image: 'img/onboarding1.png',
//           description: 'Be yourself, everyone else is already taken.'),
//       new OnBoarding(
//           image: 'img/onboarding2.png',
//           description: 'So many books, so little time.'),
//       new OnBoarding(
//           image: 'img/onboarding3.png',
//           description: 'A room without books is like a body without a soul.'),
//     ];
//   }
// }

class OnboardingItem {
  final String title;
  final String subtitle;
  final String image;

  const OnboardingItem({this.title, this.subtitle, this.image});
}

class OnboardingItems {
  static List<OnboardingItem> loadOnboardingItem() {
    const fi = <OnboardingItem>[
      OnboardingItem(
        title: "Welcome to Cartvorie",
        subtitle:
            "We make your online grocery shopping and delivery a seamless effort. You can use our app to order from your favorite stores and have them delivered to your door step. All stores are verified.",
        image: "img/intro1.jpg",
      ),
      OnboardingItem(
        title: "Quick Pickup & Delivery",
        subtitle:
            "You have item to be pickup fast? Yes, we can also help with your pickup and Delivery.",
        image: "img/intro2.jpg",
      ),
      OnboardingItem(
        title: "Our Delivery Partner",
        subtitle:
            "Become a delivery partner by helping in grocery pickup and delivery to make extra income.",
        image: "img/intro3.jpg",
      )
    ];
    return fi;
  }
}
