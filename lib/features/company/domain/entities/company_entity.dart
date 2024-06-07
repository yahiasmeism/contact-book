import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'company_entity.g.dart';

@HiveType(typeId: 0)
class CompanyEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String companyName;
  @HiveField(2)
  final String vatNumber;
  @HiveField(3)
  final String streetOne;
  @HiveField(4)
  final String? streetTwo;
  @HiveField(5)
  final String city;
  @HiveField(6)
  final String state;
  @HiveField(7)
  final String zip;
  @HiveField(8)
  final String country;

  const CompanyEntity(
      {required this.id,
      required this.companyName,
      required this.vatNumber,
      required this.streetOne,
      this.streetTwo,
      required this.city,
      required this.state,
      required this.zip,
      required this.country});

  @override
  List<Object?> get props => [
        id,
        companyName,
        vatNumber,
        streetOne,
        streetTwo,
        city,
        state,
        zip,
        country,
      ];
}
