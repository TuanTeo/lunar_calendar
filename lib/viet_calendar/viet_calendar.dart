import 'dart:math';

import 'package:lunar_calendar/viet_calendar/can_chi.dart';

class VietCalendar {
  static const double PI = pi;
  static const double TIME_ZONE = 7.0;

  static int jdFromDate(int dd, int mm, int yy) {
    int a = (14 - mm) ~/ 12;
    int y = yy + 4800 - a;
    int m = mm + 12 * a - 3;
    int jd = dd + ((153 * m + 2) ~/ 5) + 365 * y + y ~/ 4 - y ~/ 100 + y ~/ 400 - 32045;
    if (jd < 2299161) {
      jd = dd + ((153 * m + 2) ~/ 5) + 365 * y + y ~/ 4 - 32083;
    }
    //jd = jd - 1721425;
    return jd;
  }

  static List<int> jdToDate(int jd) {
    int a, b, c;
    if (jd > 2299160) {
      a = jd + 32044;
      b = (4 * a + 3) ~/ 146097;
      c = a - (b * 146097) ~/ 4;
    } else {
      b = 0;
      c = jd + 32082;
    }
    int d = (4 * c + 3) ~/ 1461;
    int e = c - (1461 * d) ~/ 4;
    int m = (5 * e + 2) ~/ 153;
    int day = e - ((153 * m + 2) ~/ 5) + 1;
    int month = m + 3 - 12 * (m ~/ 10);
    int year = b * 100 + d - 4800 + (m ~/ 10);
    return [day, month, year];
  }

  static double sunLongitude(double jdn) {
    return sunLongitudeAA98(jdn);
  }

  static double sunLongitudeAA98(double jdn) {
    double julianTime = (jdn - 2451545.0) / 36525;
    double squareJulianTime = julianTime * julianTime;
    double dr = PI / 180;
    double meanAnomaly =
        357.52910 + 35999.05030 * julianTime - 0.0001559 * squareJulianTime - 0.00000048 * julianTime * squareJulianTime;
    double meanLongitude = 280.46645 + 36000.76983 * julianTime + 0.0003032 * squareJulianTime;
    double dl = (1.914600 - 0.004817 * julianTime - 0.000014 * squareJulianTime) * sin(dr * meanAnomaly);
    dl += (0.019993 - 0.000101 * julianTime) * sin(dr * 2 * meanAnomaly) + 0.000290 * sin(dr * 3 * meanAnomaly);
    double trueLongitude = meanLongitude + dl;
    trueLongitude -= 360 * (trueLongitude / 360).floorToDouble();
    return trueLongitude;
  }

  static double newMoon(int k) {
    return newMoonAA98(k);
  }

  static double newMoonAA98(int k) {
    double julianTime = k / 1236.85;
    double squareJulianTime = julianTime * julianTime;
    double cubicJulianTime = squareJulianTime * julianTime;
    double dr = PI / 180;
    double jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * squareJulianTime - 0.000000155 * cubicJulianTime;
    jd1 += 0.00033 * sin((166.56 + 132.87 * julianTime - 0.009173 * squareJulianTime) * dr);
    double sunMeanAnomaly = 359.2242 + 29.10535608 * k - 0.0000333 * squareJulianTime - 0.00000347 * cubicJulianTime;
    double moonMeanAnomaly =
        306.0253 + 385.81691806 * k + 0.0107306 * squareJulianTime + 0.00001236 * cubicJulianTime;
    double f = 21.2964 + 390.67050646 * k - 0.0016528 * squareJulianTime - 0.00000239 * cubicJulianTime;
    double c1 = (0.1734 - 0.000393 * julianTime) * sin(sunMeanAnomaly * dr) + 0.0021 * sin(2 * dr * sunMeanAnomaly);
    c1 = c1 - 0.4068 * sin(moonMeanAnomaly * dr) + 0.0161 * sin(dr * 2 * moonMeanAnomaly);
    c1 -= 0.0004 * sin(dr * 3 * moonMeanAnomaly);
    c1 = c1 + 0.0104 * sin(dr * 2 * f) - 0.0051 * sin(dr * (sunMeanAnomaly + moonMeanAnomaly));
    c1 = c1 - 0.0074 * sin(dr * (sunMeanAnomaly - moonMeanAnomaly)) + 0.0004 * sin(dr * (2 * f + sunMeanAnomaly));
    c1 = c1 - 0.0004 * sin(dr * (2 * f - sunMeanAnomaly)) - 0.0006 * sin(dr * (2 * f + moonMeanAnomaly));
    c1 += 0.0010 * sin(dr * (2 * f - moonMeanAnomaly)) + 0.0005 * sin(dr * (2 * moonMeanAnomaly + sunMeanAnomaly));
    double deltAt;
    if (julianTime < -11) {
      deltAt = 0.001 + 0.000839 * julianTime + 0.0002261 * squareJulianTime - 0.00000845 * cubicJulianTime -
          0.000000081 * julianTime * cubicJulianTime;
    } else {
      deltAt = -0.000278 + 0.000265 * julianTime + 0.000262 * squareJulianTime;
    }
    return jd1 + c1 - deltAt;
  }

  static int floorInt(double d) {
    return d.floor();
  }

  static double getSunLongitude(int dayNumber, double timeZone) {
    return sunLongitude(dayNumber - 0.5 - timeZone / 24);
  }

  static int getNewMoonDay(int k, double timeZone) {
    double jd = newMoon(k);
    return floorInt(jd + 0.5 + timeZone / 24);
  }

  static int getLunarMonth11(int yy, double timeZone) {
    double off = jdFromDate(31, 12, yy) - 2415021.076998695;
    int k = floorInt(off / 29.530588853);
    int nm = getNewMoonDay(k, timeZone);
    int sunLong = floorInt(getSunLongitude(nm, timeZone) / 30);
    if (sunLong >= 9) {
      nm = getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

  static int getLeapMonthOffset(int a11, double timeZone) {
    int k = floorInt(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    int last; // Month 11 contains point of sun longutide 3*PI/2 (December solstice)
    int i = 1; // We start with the month following lunar month 11
    int arc = floorInt(getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone) / 30);
    do {
      last = arc;
      i++;
      arc = floorInt(getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone) / 30);
    } while (arc != last && i < 14);
    return i - 1;
  }

  static List<int> convertSolar2Lunar(int dd, int mm, int yy, double timeZone) {
    int lunarDay;
    int lunarMonth;
    int lunarYear;
    int lunarLeap;
    int dayNumber = jdFromDate(dd, mm, yy);
    int k = floorInt((dayNumber - 2415021.076998695) / 29.530588853);
    int monthStart = getNewMoonDay(k + 1, timeZone);
    if (monthStart > dayNumber) {
      monthStart = getNewMoonDay(k, timeZone);
    }
    int a11 = getLunarMonth11(yy, timeZone);
    int b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = yy;
      a11 = getLunarMonth11(yy - 1, timeZone);
    } else {
      lunarYear = yy + 1;
      b11 = getLunarMonth11(yy + 1, timeZone);
    }
    lunarDay = dayNumber - monthStart + 1;
    int diff = ((monthStart - a11) / 29).floor();
    lunarLeap = 0;
    lunarMonth = diff + 11;
    if (b11 - a11 > 365) {
      int leapMonthDiff = getLeapMonthOffset(a11, timeZone);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        if (diff == leapMonthDiff) {
          lunarLeap = 1;
        }
      }
    }
    if (lunarMonth > 12) {
      lunarMonth -= 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear -= 1;
    }
    return [lunarDay, lunarMonth, lunarYear, lunarLeap];
  }

  static List<int> convertLunar2Solar(int lunarDay, int lunarMonth, int lunarYear, int lunarLeap, double timeZone) {
    int a11;
    int b11;
    if (lunarMonth < 11) {
      a11 = getLunarMonth11(lunarYear - 1, timeZone);
      b11 = getLunarMonth11(lunarYear, timeZone);
    } else {
      a11 = getLunarMonth11(lunarYear, timeZone);
      b11 = getLunarMonth11(lunarYear + 1, timeZone);
    }
    int k = floorInt(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    int off = lunarMonth - 11;
    if (off < 0) {
      off += 12;
    }
    if (b11 - a11 > 365) {
      int leapOff = getLeapMonthOffset(a11, timeZone);
      int leapMonth = leapOff - 2;
      if (leapMonth < 0) {
        leapMonth += 12;
      }
      if (lunarLeap != 0 && lunarMonth != leapMonth) {
        print("Invalid input!");
        return [0, 0, 0];
      } else if (lunarLeap != 0 || off >= leapOff) {
        off += 1;
      }
    }
    int monthStart = getNewMoonDay(k + off, timeZone);
    return jdToDate(monthStart + lunarDay - 1);
  }

  static String yearCan(int year) {
    var i = (year + 6) % 10;
    return CanChi.can.elementAt(i);
  }

  static String yearChi(int year) {
    var i = (year + 8) % 12;
    return CanChi.chi.elementAt(i);
  }
}