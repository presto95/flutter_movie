class Movie {
  List<Movies> movies;
  int orderType;

  Movie({this.movies, this.orderType});

  Movie.fromJson(Map<String, dynamic> json) {
    if (json['movies'] != null) {
      movies = new List<Movies>();
      json['movies'].forEach((v) {
        movies.add(new Movies.fromJson(v));
      });
    }
    orderType = json['order_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movies != null) {
      data['movies'] = this.movies.map((v) => v.toJson()).toList();
    }
    data['order_type'] = this.orderType;
    return data;
  }
}

class Movies {
  String title;
  double userRating;
  int grade;
  int reservationGrade;
  String id;
  String date;
  String thumb;
  double reservationRate;

  Movies(
      {this.title,
        this.userRating,
        this.grade,
        this.reservationGrade,
        this.id,
        this.date,
        this.thumb,
        this.reservationRate});

  Movies.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    userRating = json['user_rating'];
    grade = json['grade'];
    reservationGrade = json['reservation_grade'];
    id = json['id'];
    date = json['date'];
    thumb = json['thumb'];
    reservationRate = json['reservation_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['user_rating'] = this.userRating;
    data['grade'] = this.grade;
    data['reservation_grade'] = this.reservationGrade;
    data['id'] = this.id;
    data['date'] = this.date;
    data['thumb'] = this.thumb;
    data['reservation_rate'] = this.reservationRate;
    return data;
  }
}