class Cateogry{
  late String _name , _image ;
  Cateogry(this._name, this._image);

  get image => _image;

  set image(value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}