/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * raspi_pitchshiftdeployment.c
 *
 * Code generation for function 'raspi_pitchshiftdeployment'
 *
 */

/* Include files */
#include "raspi_pitchshiftdeployment.h"
#include "PitchShifter.h"
#include "audiocapture.h"
#include "audioplayer.h"
#include "raspi_pitchshiftdeployment_data.h"
#include "raspi_pitchshiftdeployment_initialize.h"
#include "rt_nonfinite.h"
#include <math.h>

/* Function Declarations */
static double rt_powd_snf(double u0, double u1);
static double rt_roundd_snf(double u);

/* Function Definitions */
static double rt_powd_snf(double u0, double u1)
{
  double y;
  double d;
  double d1;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = rtNaN;
  } else {
    d = fabs(u0);
    d1 = fabs(u1);
    if (rtIsInf(u1)) {
      if (d == 1.0) {
        y = 1.0;
      } else if (d > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (d1 == 0.0) {
      y = 1.0;
    } else if (d1 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > floor(u1))) {
      y = rtNaN;
    } else {
      y = pow(u0, u1);
    }
  }

  return y;
}

static double rt_roundd_snf(double u)
{
  double y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

void raspi_pitchshiftdeployment(void)
{
  static audiopluginexample_PitchShifter pitchShifter;
  c_raspi_internal_codegen_audioc captureObj;
  c_raspi_internal_codegen_audiop playbackObj;
  bool flag;
  int k;
  short input[9600];
  c_dspcodegen_VariableFractional *obj;
  audiopluginexample_PitchShifter *b_obj;
  int buffIdx;
  double x;
  static double pitchShifted[9600];
  int i;
  static const double dv[16] = { -0.16666666666666663, 0.49999999999999994, -0.5,
    0.16666666666666669, 0.50000000000000011, -1.0000000000000002, 0.5, 0.0,
    -0.33333333333333359, -0.49999999999999889, 1.0, -0.16666666666666641, 0.0,
    1.0, 0.0, 0.0 };

  short b_i;
  dsp_VariableFractionalDelay_0 *c_obj;
  if (!isInitialized_raspi_pitchshiftdeployment) {
    raspi_pitchshiftdeployment_initialize();
  }

  pitchShifter.pShifter.matlabCodegenIsDeleted = true;
  pitchShifter.matlabCodegenIsDeleted = true;
  captureObj.QueueDuration = 0.5;
  captureObj.isInitialized = 0;
  captureObj.matlabCodegenIsDeleted = false;
  playbackObj.QueueDuration = 0.5;
  playbackObj.isInitialized = 0;
  playbackObj.matlabCodegenIsDeleted = false;
  pitchShifter.isInitialized = 0;
  flag = (pitchShifter.isInitialized == 1);
  if (flag) {
    pitchShifter.TunablePropsChanged = true;
  }

  pitchShifter.PitchShift = 8.0;
  flag = (pitchShifter.isInitialized == 1);
  if (flag) {
    pitchShifter.TunablePropsChanged = true;
  }

  pitchShifter.Overlap = 0.3;
  pitchShifter.matlabCodegenIsDeleted = false;
  pitchShifter.PrivateSampleRate = 8192.0;
  for (k = 0; k < 3000; k++) {
    audiocapture_capture(&captureObj, input);
    flag = (pitchShifter.isInitialized == 1);
    if (flag) {
      pitchShifter.TunablePropsChanged = true;
    }

    pitchShifter.PitchShift = -5.0;
    flag = (pitchShifter.isInitialized == 1);
    if (flag) {
      pitchShifter.TunablePropsChanged = true;
    }

    pitchShifter.Overlap = 0.2;
    b_obj = &pitchShifter;
    if (pitchShifter.isInitialized != 1) {
      pitchShifter.isSetupComplete = false;
      pitchShifter.isInitialized = 1;
      obj = &pitchShifter.pShifter;
      b_obj->pShifter.isInitialized = 0;

      /* System object Constructor function: dsp.VariableFractionalDelay */
      obj->cSFunObject.P0_IC = 0.0;
      for (i = 0; i < 16; i++) {
        obj->cSFunObject.P1_FilterArgs[i] = dv[i];
      }

      b_obj->pShifter.matlabCodegenIsDeleted = false;
      pitchShifter.Phase1State = 0.0;
      x = 1.0 - pitchShifter.Overlap;
      pitchShifter.Phase2State = x;
      x = pitchShifter.PitchShift;
      x = rt_roundd_snf(x);
      pitchShifter.pRate = (1.0 - rt_powd_snf(2.0, x / 12.0)) / 0.03;
      x = pitchShifter.PrivateSampleRate;
      pitchShifter.pPhaseStep = pitchShifter.pRate / x;
      pitchShifter.pFaderGain = 1.0 / pitchShifter.Overlap;
      pitchShifter.isSetupComplete = true;
      pitchShifter.TunablePropsChanged = false;
      pitchShifter.Phase1State = 0.0;
      x = 1.0 - pitchShifter.Overlap;
      pitchShifter.Phase2State = x;
      obj = &pitchShifter.pShifter;
      if (b_obj->pShifter.isInitialized == 1) {
        c_obj = &b_obj->pShifter.cSFunObject;

        /* System object Initialization function: dsp.VariableFractionalDelay */
        obj->cSFunObject.W0_BUFF_OFFSET = 5760;
        obj->cSFunObject.W0_BUFF_OFFSET += 2;
        buffIdx = 0;
        for (i = 0; i < 11526; i++) {
          c_obj->W1_BUFF[buffIdx] = c_obj->P0_IC;
          buffIdx++;
        }
      }

      x = pitchShifter.PrivateSampleRate;
      pitchShifter.pSampsDelay = rt_roundd_snf(0.03 * x);
      x = pitchShifter.PitchShift;
      x = rt_roundd_snf(x);
      pitchShifter.pRate = (1.0 - rt_powd_snf(2.0, x / 12.0)) / 0.03;
      x = pitchShifter.PrivateSampleRate;
      pitchShifter.pPhaseStep = pitchShifter.pRate / x;
      pitchShifter.pFaderGain = 1.0 / pitchShifter.Overlap;
    }

    if (pitchShifter.TunablePropsChanged) {
      pitchShifter.TunablePropsChanged = false;
      x = pitchShifter.PitchShift;
      x = rt_roundd_snf(x);
      pitchShifter.pRate = (1.0 - rt_powd_snf(2.0, x / 12.0)) / 0.03;
      x = pitchShifter.PrivateSampleRate;
      pitchShifter.pPhaseStep = pitchShifter.pRate / x;
      pitchShifter.pFaderGain = 1.0 / pitchShifter.Overlap;
    }

    for (buffIdx = 0; buffIdx < 9600; buffIdx++) {
      pitchShifted[buffIdx] = input[buffIdx];
    }

    PitchShifter_stepImpl(&pitchShifter, pitchShifted);
    for (buffIdx = 0; buffIdx < 9600; buffIdx++) {
      x = rt_roundd_snf(pitchShifted[buffIdx]);
      if (x < 32768.0) {
        if (x >= -32768.0) {
          b_i = (short)x;
        } else {
          b_i = MIN_int16_T;
        }
      } else if (x >= 32768.0) {
        b_i = MAX_int16_T;
      } else {
        b_i = 0;
      }

      input[buffIdx] = b_i;
    }

    audioplayer_play(&playbackObj, input);
  }

  if (!pitchShifter.matlabCodegenIsDeleted) {
    pitchShifter.matlabCodegenIsDeleted = true;
    if (pitchShifter.isInitialized == 1) {
      pitchShifter.isInitialized = 2;
    }
  }

  obj = &pitchShifter.pShifter;
  if (!obj->matlabCodegenIsDeleted) {
    obj->matlabCodegenIsDeleted = true;
    if (obj->isInitialized == 1) {
      obj->isInitialized = 2;
    }
  }
}

/* End of code generation (raspi_pitchshiftdeployment.c) */
