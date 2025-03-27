import 'package:intl/intl.dart';

class Event {
  final int id;
  final String title;
  final String shortDescription;
  final String description;
  final String startDate;
  final String endDate;
  final String earlyBirdEndDate;
  final String createdAt;
  final int createdBy;
  final String updatedAt;
  final int updatedBy;
  final String? deletedAt;
  final int isActive;
  final String location;
  final String time;
  final String endTime;
  final String bannerImage;
  final String imageUrl;
  final String cpdPoint;
  final int type;
  final List<EventPricing> eventPricing;
  final String eventimageurl;

  Event({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.earlyBirdEndDate,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    this.deletedAt,
    required this.isActive,
    required this.location,
    required this.time,
    required this.endTime,
    required this.bannerImage,
    required this.imageUrl,
    required this.cpdPoint,
    required this.type,
    required this.eventPricing,
    required this.eventimageurl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 0,
      title: json['name'] ?? 'No Title',
      shortDescription: json['shortdescription'] ?? '',
      description: json['description'] ?? '',
      startDate: json['startdate'] ?? '',
      endDate: json['enddate'] ?? '',
      earlyBirdEndDate: json['earlybirdenddate'] ?? '',
      createdAt: json['created_at'] ?? '',
      createdBy: json['created_by'] ?? 0,
      updatedAt: json['updated_at'] ?? '',
      updatedBy: json['updated_by'] ?? 0,
      deletedAt: json['deleted_at'],
      isActive: json['is_active'] ?? 0,
      location: json['location'] ?? 'No Location',
      time: json['time'] ?? '',
      endTime: json['endtime'] ?? '',
      bannerImage: json['bannerimage'] ?? '',
      imageUrl: json['eventimage'] ?? '',
      cpdPoint: json['cpdpoint'] ?? '',
      type: json['type'] ?? 0,
      eventPricing: (json['event_pricing'] as List<dynamic>?)
              ?.map((e) => EventPricing.fromJson(e))
              .toList() ??
          [],
      eventimageurl: json['eventimageurl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'shortdescription': shortDescription,
      'description': description,
      'startdate': startDate,
      'enddate': endDate,
      'earlybirdenddate': earlyBirdEndDate,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
      'is_active': isActive,
      'location': location,
      'time': time,
      'endtime': endTime,
      'bannerimage': bannerImage,
      'eventimage': imageUrl,
      'cpdpoint': cpdPoint,
      'type': type,
      'event_pricing': eventPricing.map((pricing) => pricing.toJson()).toList(),
      'formattedDate': formattedDate,  // ✅ Include formattedDate
      'formattedTime': formattedTime,  // ✅ Include formattedTime
      'eventimageurl': eventimageurl,
    };
  }

  // Convert `startDate` and `endDate` to readable duration format
  String get formattedDate {
    try {
      DateTime parsedStart = DateTime.parse(startDate);
      DateTime parsedEnd = DateTime.parse(endDate);

      String startMonth = DateFormat('MMMM').format(parsedStart);
      String startDay = DateFormat('d').format(parsedStart);
      String endDay = DateFormat('d').format(parsedEnd);
      String year = DateFormat('yyyy').format(parsedStart);

      if (startMonth == DateFormat('MMMM').format(parsedEnd) &&
          year == DateFormat('yyyy').format(parsedEnd)) {
        return "$startMonth $startDay - $endDay, $year"; // May 22 - 24, 2025
      } else {
        String formattedStart = DateFormat('MMMM d, yyyy').format(parsedStart);
        String formattedEnd = DateFormat('MMMM d, yyyy').format(parsedEnd);
        return "$formattedStart - $formattedEnd";
      }
    } catch (e) {
      return "$startDate - $endDate"; // Return raw values if parsing fails
    }
  }

  String get formattedTime {
    try {
      // Normalize time format by ensuring space before AM/PM
      String normalizedStartTime = time.replaceAll(RegExp(r'(\d{2}:\d{2}:\d{2})(am|pm)', caseSensitive: false), r'\1 \2').toUpperCase();
      String normalizedEndTime = endTime.replaceAll(RegExp(r'(\d{2}:\d{2}:\d{2})(am|pm)', caseSensitive: false), r'\1 \2').toUpperCase();

      // Define potential date formats
      List<DateFormat> formats = [
        DateFormat("yyyy-MM-dd HH:mm:ss"),   // 24-hour format
        DateFormat("yyyy-MM-dd hh:mm:ss a")  // 12-hour format with AM/PM
      ];

      DateTime? parsedStart;
      DateTime? parsedEnd;

      // Try parsing start time
      for (var format in formats) {
        try {
          parsedStart = format.parse(normalizedStartTime);
          break;
        } catch (e) {}
      }

      // Try parsing end time
      for (var format in formats) {
        try {
          parsedEnd = format.parse(normalizedEndTime);
          break;
        } catch (e) {}
      }

      // Ensure both times were successfully parsed
      if (parsedStart == null || parsedEnd == null) {
        throw FormatException("Invalid time format");
      }

      // Convert to "hh:mm a" format (08:00 AM - 05:00 PM)
      String formattedStart = DateFormat("hh:mm a").format(parsedStart);
      String formattedEnd = DateFormat("hh:mm a").format(parsedEnd);

      return "$formattedStart - $formattedEnd"; // Example: "08:00 AM - 05:00 PM"
    } catch (e) {
      print("Error formatting time: $e");
      return "$time - $endTime"; // Fallback to raw values if parsing fails
    }
  }

}

class EventPricing {
  final int id;
  final int eventId;
  final int memberTypeId;
  final String amount;
  final String amountWithCharges;
  final String earlyBirdAmount;
  final String earlyBirdAmountWithCharges;
  final String pwdSeniorAmount;
  final String pwdSeniorAmountWithCharge;
  final String earlyBirdPwdSeniorAmount;
  final String earlyBirdPwdSeniorAmountWithCharge;
  final String newBoardPasserAmt;
  final String newBoardPasserAmtWithCC;
  final String earlyBirdNewBoardPasserAmt;
  final String earlyBirdNewBoardPasserAmtWithCC;
  final String createdAt;
  final int createdBy;
  final String updatedAt;
  final int? updatedBy;
  final String? deletedAt;
  final int isActive;

  EventPricing({
    required this.id,
    required this.eventId,
    required this.memberTypeId,
    required this.amount,
    required this.amountWithCharges,
    required this.earlyBirdAmount,
    required this.earlyBirdAmountWithCharges,
    required this.pwdSeniorAmount,
    required this.pwdSeniorAmountWithCharge,
    required this.earlyBirdPwdSeniorAmount,
    required this.earlyBirdPwdSeniorAmountWithCharge,
    required this.newBoardPasserAmt,
    required this.newBoardPasserAmtWithCC,
    required this.earlyBirdNewBoardPasserAmt,
    required this.earlyBirdNewBoardPasserAmtWithCC,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    required this.isActive,
  });

  factory EventPricing.fromJson(Map<String, dynamic> json) {
    return EventPricing(
      id: json['id'] ?? 0,
      eventId: json['event_id'] ?? 0,
      memberTypeId: json['membertype_id'] ?? 0,
      amount: json['amount'] ?? '0.00',
      amountWithCharges: json['amountwithcharges'] ?? '0.00',
      earlyBirdAmount: json['earlybirdamount'] ?? '0.00',
      earlyBirdAmountWithCharges: json['earlybirdamountwithcharges'] ?? '0.00',
      pwdSeniorAmount: json['pwdsenioramount'] ?? '0.00',
      pwdSeniorAmountWithCharge: json['pwdsenioramountwithcharge'] ?? '0.00',
      earlyBirdPwdSeniorAmount: json['earlybirdpwdsenioramount'] ?? '0.00',
      earlyBirdPwdSeniorAmountWithCharge:
          json['earlybirdpwdsenioramountwithcharge'] ?? '0.00',
      newBoardPasserAmt: json['newboardpasseramt'] ?? '0.00',
      newBoardPasserAmtWithCC: json['newboardpasseramtwithcc'] ?? '0.00',
      earlyBirdNewBoardPasserAmt: json['earlybirdnewboardpasseramt'] ?? '0.00',
      earlyBirdNewBoardPasserAmtWithCC:
          json['earlybirdnewboardpasseramtwithcc'] ?? '0.00',
      createdAt: json['created_at'] ?? '',
      createdBy: json['created_by'] ?? 0,
      updatedAt: json['updated_at'] ?? '',
      updatedBy: json['updated_by'],
      deletedAt: json['deleted_at'],
      isActive: json['is_active'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'membertype_id': memberTypeId,
      'amount': amount,
      'amountwithcharges': amountWithCharges,
      'earlybirdamount': earlyBirdAmount,
      'earlybirdamountwithcharges': earlyBirdAmountWithCharges,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
      'is_active': isActive,
    };
  }
}
