class SliderModel {
  String image;
  String button;
  String description;

  SliderModel({this.image, this.button, this.description});
}

class SliderList {
  List<SliderModel> _list;

  List<SliderModel> get list => _list;

  SliderList() {
    _list = [
      SliderModel(
          image: 'img/slider1.jpg',
          button: 'here',
          description: 'Browse our list of categories'),
      SliderModel(
          image: 'img/slider2.jpg',
          button: 'Explore Stores',
          description: 'Find stores of your choice'),
      SliderModel(
          image: 'img/slider3.jpg',
          button: 'Search',
          description: 'Search products across the app.'),
      SliderModel(
          image: 'img/slider4.jpg',
          button: 'Quick Pickup',
          description:
              'Request our driver to pick up an item to your location'),
    ];
  }
}
