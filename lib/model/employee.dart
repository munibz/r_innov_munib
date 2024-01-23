// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(tableName: 'employee')
class Employee {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? name;
  String? designation;
  String? fromDate;
  String? toDate;

  Employee({
    this.id,
    this.name,
    this.designation,
    this.fromDate,
    this.toDate,
  });

  Employee copyWith({
    int? id,
    String? name,
    String? designation,
    String? fromDate,
    String? toDate,
  }) =>
      Employee(
        id:id ?? this.id,
        name: name ?? this.name,
        designation: designation ?? this.designation,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id':id,
      'name': name,
      'designation': designation,
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id:map['id'] != null ? map['id'] as int :null,
      name: map['name'] != null ? map['name'] as String : null,
      designation:
          map['designation'] != null ? map['designation'] as String : null,
      fromDate: map['fromDate'] != null ? map['fromDate'] as String : null,
      toDate: map['toDate'] != null ? map['toDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.designation == designation &&
        other.fromDate == fromDate &&
        other.toDate == toDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        designation.hashCode ^
        fromDate.hashCode ^
        toDate.hashCode;
  }
}
