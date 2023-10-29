import 'dart:developer';
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'package:win32/win32.dart';

import 'utils.dart';

class CpuRepository {
  Future<double> _cpuProccess() async {
    try {
      final lastLpidletime = calloc<FILETIME>();
      final lastLpkerneltime = calloc<FILETIME>();
      final lastLpusertime = calloc<FILETIME>();

      final lpIdleTime = calloc<FILETIME>();
      final lpKernelTime = calloc<FILETIME>();
      final lpUserTime = calloc<FILETIME>();
      //
      final result = GetSystemTimes(lastLpidletime, lastLpkerneltime, lastLpusertime);

      await Future.delayed(const Duration(milliseconds: 1000));

      final result2 = GetSystemTimes(lpIdleTime, lpKernelTime, lpUserTime);
      if (result == FALSE && result2 == FALSE) {
        //
        free(lastLpidletime);
        free(lpIdleTime);

        free(lastLpkerneltime);
        free(lpKernelTime);

        free(lastLpusertime);
        free(lpUserTime);
        //
        return 0;
      }
      //
      final usr = fileTimeToSeconds(lpUserTime.ref) - fileTimeToSeconds(lastLpusertime.ref);
      final ker = fileTimeToSeconds(lpKernelTime.ref) - fileTimeToSeconds(lastLpkerneltime.ref);
      final idl = fileTimeToSeconds(lpIdleTime.ref) - fileTimeToSeconds(lastLpidletime.ref);
      final sys = ker + usr;
      final cpu = (sys - idl) * 100 / sys;
      //
      free(lastLpidletime);
      free(lpIdleTime);

      free(lastLpkerneltime);
      free(lpKernelTime);

      free(lastLpusertime);
      free(lpUserTime);
      //
      return cpu;
    } catch (e) {
      log(e.toString());
    }
    return 0;
  }

  Stream<double> cpuUsageStream() async* {
    yield* Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return _cpuProccess();
    }).asyncMap(
      (value) async => await value,
    );
  }
}
