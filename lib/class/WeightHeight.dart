class WeightHeight{

  late double _weight;
  late double _height;
  late int _month;

  WeightHeight(this._month,this._weight,this._height);

  double get weight => _weight;
  double get height => _height;
  int get month => _month;

  set weight(double value){
    _weight=value;
  }

  set height(double value){
    _height=value;
  }

  set month(int value){
    _month=value;
  }

  Map<String,dynamic> toJson(){
    return{
      "month":month,
      "weight":weight,
      "height":height,
    };
  }

  factory WeightHeight.fromJson(json) {
    return WeightHeight(
       json['month'],
       json['weight'],
       json['height'],
     );
  }





}