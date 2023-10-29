import 'dart:developer';

import 'package:win32/win32.dart';

/// Converts FILETIME format to seconds.
double fileTimeToSeconds(FILETIME fileTime) => ((fileTime.dwHighDateTime << 32) + fileTime.dwLowDateTime) / 10E6;

/// Constructs a DateTime from SYSTEMTIME format.
DateTime systemTimeToDateTime(SYSTEMTIME systemTime, {bool convertToLocalTimeZone = true}) {
  final dateTime = DateTime.utc(
    systemTime.wYear,
    systemTime.wMonth,
    systemTime.wDay,
    systemTime.wHour,
    systemTime.wMinute,
    systemTime.wSecond,
    systemTime.wMilliseconds,
  );

  return convertToLocalTimeZone ? dateTime.toLocal() : dateTime;
}

int getProcessorCount() {
  try {
    return GetActiveProcessorCount(ALL_PROCESSOR_GROUPS);
  } catch (e) {
    log(e.toString());
  }
  return 0;
}
