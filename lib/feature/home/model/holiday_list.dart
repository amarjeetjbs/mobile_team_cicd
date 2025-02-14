class HolidayList {
  List<Holidays>? holidays;

  HolidayList({this.holidays});

  HolidayList.fromJson(Map<String, dynamic> json) {
    if (json['holidays'] != null) {
      holidays = <Holidays>[];
      json['holidays'].forEach((v) {
        holidays!.add(Holidays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (holidays != null) {
      data['holidays'] = holidays!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'HolidayList{holidays: $holidays}';
  }
}

class Holidays {
  String? date;
  String? day;
  String? name;
  List<String>? states;
  List<String>? exceptionStates;

  Holidays({this.date, this.day, this.name, this.states, this.exceptionStates});

  Holidays.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    name = json['name'];
    states = json['states'].cast<String>();
    if (json['exception_states'] != null) {
      exceptionStates = json['exception_states'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['day'] = day;
    data['name'] = name;
    data['states'] = states;
    data['exception_states'] = exceptionStates;
    return data;
  }

  @override
  String toString() {
    return 'Holidays{date: $date, day: $day, name: $name, states: $states, exceptionStates: $exceptionStates}';
  }
}
