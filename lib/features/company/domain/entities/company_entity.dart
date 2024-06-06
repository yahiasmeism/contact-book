// ignore_for_file: public_member_api_docs, sort_constructors_first
class CompanyEntity {
  final int id;
  final String companyName;
  final String vatNumber;
  final String streetOne;
  final String? streetTwo;
  final String city;
  final String state;
  final String zip;
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
  bool operator ==(covariant CompanyEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.companyName == companyName &&
        other.vatNumber == vatNumber &&
        other.streetOne == streetOne &&
        other.streetTwo == streetTwo &&
        other.city == city &&
        other.state == state &&
        other.zip == zip &&
        other.country == country;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyName.hashCode ^
        vatNumber.hashCode ^
        streetOne.hashCode ^
        streetTwo.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zip.hashCode ^
        country.hashCode;
  }
}
