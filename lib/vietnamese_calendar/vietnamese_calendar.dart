import 'dart:math';

class VietnameseCalendar {
  late DateTime solarDate;
  late DateTime lunarDate;
  late VietnameseDate vietnameseDate;

  VietnameseCalendar(DateTime date) {
    solarDate = date;
    lunarDate = convertSolar2LunarDate();
    getVietnameseDate();
  }

  VietnameseDate getVietnameseDate() {
    final lunarCalendar = DateTime.utc(lunarDate.year, lunarDate.month, lunarDate.day);
    final day = lunarCalendar.day;
    final month = lunarCalendar.month;
    final year = lunarCalendar.year;

    final modLunar = year % 12;
    var chiStr = '';
    switch (modLunar) {
      case ConGiap.TI:
        chiStr = 'Tý';
        break;
      case ConGiap.SUU:
        chiStr = 'Sửu';
        break;
      case ConGiap.DAN:
        chiStr = 'Dần';
        break;
      case ConGiap.MAO:
        chiStr = 'Mão';
        break;
      case ConGiap.THIN:
        chiStr = 'Thìn';
        break;
      case ConGiap.TY:
        chiStr = 'Tỵ';
        break;
      case ConGiap.NGO:
        chiStr = 'Ngọ';
        break;
      case ConGiap.MUI:
        chiStr = 'Mùi';
        break;
      case ConGiap.THAN:
        chiStr = 'Thân';
        break;
      case ConGiap.DAU:
        chiStr = 'Dậu';
        break;
      case ConGiap.TUAT:
        chiStr = 'Tuất';
        break;
      case ConGiap.HOI:
        chiStr = 'Hợi';
        break;
    }

    final modCan = year % 10;
    var canStr = '';
    switch (modCan) {
      case MuoiCan.CANH:
        canStr = 'Canh';
        break;
      case MuoiCan.TAN:
        canStr = 'Tân';
        break;
      case MuoiCan.NHAM:
        canStr = 'Nhâm';
        break;
      case MuoiCan.QUY:
        canStr = 'Quý';
        break;
      case MuoiCan.GIAP:
        canStr = 'Giáp';
        break;
      case MuoiCan.AT:
        canStr = 'Ất';
        break;
      case MuoiCan.BINH:
        canStr = 'Bính';
        break;
      case MuoiCan.DINH:
        canStr = 'Đinh';
        break;
      case MuoiCan.MAU:
        canStr = 'Mậu';
        break;
      case MuoiCan.KY:
        canStr = 'Kỷ';
        break;
    }

    vietnameseDate = VietnameseDate(day, month, '$canStr $chiStr');
    return vietnameseDate;
  }

  DateTime convertSolar2LunarDate() {
    final timeZone = 7;
    final dayNumber = jdFromDate(solarDate);
    var k = ((dayNumber - 2415021.076998695) / 29.530588853).floor();
    var monthStart = getNewMoonDay(k + 1, timeZone);
    if (monthStart > dayNumber) {
      monthStart = getNewMoonDay(k, timeZone);
    }

    final solarYear = solarDate.year;
    var lunarYear = 0;
    var a11 = getLunarMonth11(solarYear, timeZone);
    var b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = solarYear;
      a11 = getLunarMonth11(solarYear - 1, timeZone);
    } else {
      lunarYear = solarYear + 1;
      b11 = getLunarMonth11(solarYear + 1, timeZone);
    }
    final lunarDay = dayNumber - monthStart + 1;
    final diff = ((monthStart - a11) / 29).floor();
    var lunarLeap = false;
    var lunarMonth = diff + 11;
    if (b11 - a11 > 365) {
      final leapMonthDiff = getLeapMonthOffset(a11, timeZone);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        if (diff == leapMonthDiff) {
          lunarLeap = true;
        }
      }
    }
    if (lunarMonth > 12) {
      lunarMonth -= 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear--;
    }

    return DateTime.utc(lunarYear, lunarMonth, lunarDay);
  }

  int jdFromDate(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;
    final a = ((14 - month) / 12).floor();
    final y = year + 4800 - a;
    final m = month + 12 * a - 3;
    var jd = (day + ((153 * m + 2) / 5) + 365 * y + (y / 4) - (y / 100) + (y / 400) - 32045).floor();
    if (jd < 2299161) {
      jd = (day + ((153 * m + 2) / 5) + 365 * y + (y / 4) - 32083).floor();
    }
    return jd;
  }

  int getNewMoonDay(int k, int timeZone) {
    final T = k / 1236.85;
    final T2 = T * T;
    final dr = pi / 180.0;
    final expres1 = 29.53058868 * k;
    var Jd1 = 2415020.75933 + expres1 + 0.0001178 * T2 - 0.000000155 * T2 * T;
    Jd1 = Jd1 + 0.00033 * sin((166.56 + 132.87 * T - 0.009173 * T2) * dr);
    final M = 359.2242 + 29.10535608 * k - 0.0000333 * T2 - 0.00000347 * T2 * T;
    final Mpr = 306.0253 + 385.81691806 * k + 0.0107306 * T2 + 0.00001236 * T2 * T;
    final F = 21.2964 + 390.67050646 * k - 0.0016528 * T2 - 0.00000239 * T2 * T;

    var C1 = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    C1 = C1 - 0.4068 * sin(Mpr * dr) + 0.0161 * sin(2 * dr * Mpr);
    C1 = C1 - 0.0004 * sin(3 * dr * Mpr);
    C1 = C1 + 0.0104 * sin(2 * dr * F) - 0.0051 * sin(dr * (M + Mpr));
    C1 = C1 - 0.0074 * sin(dr * (M - Mpr)) + 0.0004 * sin(dr * (2 * F + M));
    C1 = C1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + Mpr));
    C1 = C1 + 0.0010 * sin(dr * (2 * F - Mpr)) + 0.0005 * sin(dr * (2 * Mpr + M));
    var deltat = 0.0;
    if (T < -11) {
      deltat = 0.001 + 0.000839 * T + 0.0002261 * T2 - 0.00000845 * T2 * T - 0.000000081 * T * T * T;
    } else {
      deltat = -0.000278 + 0.000265 * T + 0.000262 * T2;
    }
    var JdNew = Jd1 + C1 - deltat;
    return (JdNew + 0.5 + (timeZone / 24.0)).floor();
  }

  int getSunLongitude(int jdn, int timeZone) {
    final T = (jdn - 2451545.5 - timeZone / 24) / 36525;
    final T2 = T * T;
    final dr = pi / 180.0;
    final M = 357.52910 + 35999.05030 * T - 0.0001559 * T2 - 0.00000048 * T * T2;
    final L0 = 280.46645 + 36000.76983 * T + 0.0003032 * T2;
    var DL = (1.914600 - 0.004817 * T - 0.000014 * T2) * sin(dr * M);
    DL = DL + (0.019993 - 0.000101 * T) * sin(dr * 2 * M) + 0.000290 * sin(dr * 3 * M);
    var L = L0 + DL;
    L = L * dr;
    L = L - 2 * pi * (L / (2 * pi)).floor();
    return (L / pi * 6).floor();
  }

  int getLunarMonth11(int year, int timeZone) {
    final date = DateTime.utc(year, 12, 31);
    final off = jdFromDate(date) - 2415021;
    final k = (off / 29.530588853).floor();
    var nm = getNewMoonDay(k, timeZone);
    final sunLong = getSunLongitude(nm, timeZone);
    if (sunLong >= 9) {
      nm = getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

  int getLeapMonthOffset(int a11, int timeZone) {
    var k = ((a11 - 2415021.076998695) / 29.530588853 + 0.5).floor();
    var last = 0;
    var i = 1;
    var arc = getSunLongitude(getNewMoonDay(k + 1, timeZone), timeZone);
    while (arc != last && i < 14) {
      last = arc;
      i += 1;
      arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    }
    return i - 1;
  }
}

class VietnameseDate {
  int day;
  int month;
  String year;

  VietnameseDate(this.day, this.month, this.year);

  String toString() {
    var result = '';
    var strNgay = 'Ngày $day';
    if (day < 10) {
      strNgay = 'Mùng $day';
    }
    var strThang = 'tháng $month';
    if (month == 1) {
      strThang = 'tháng Giêng';
    } else if (month == 12) {
      strThang = 'tháng Chạp';
    }

    if (month == 1 && day < 4) {
      result = '$strNgay Tết $year';
    } else {
      result = '$strNgay, $strThang, năm $year';
    }
    return result;
  }
}

class ConGiap {
  static const int TI = 0;
  static const int SUU = 1;
  static const int DAN = 2;
  static const int MAO = 3;
  static const int THIN = 4;
  static const int TY = 5;
  static const int NGO = 6;
  static const int MUI = 7;
  static const int THAN = 8;
  static const int DAU = 9;
  static const int TUAT = 10;
  static const int HOI = 11;
}

class MuoiCan {
  static const int CANH = 0;
  static const int TAN = 1;
  static const int NHAM = 2;
  static const int QUY = 3;
  static const int GIAP = 4;
  static const int AT = 5;
  static const int BINH = 6;
  static const int DINH = 7;
  static const int MAU = 8;
  static const int KY = 9;
}