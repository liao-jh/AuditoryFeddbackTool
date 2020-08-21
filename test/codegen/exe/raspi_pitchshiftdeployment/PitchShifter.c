/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * PitchShifter.c
 *
 * Code generation for function 'PitchShifter'
 *
 */

/* Include files */
#include "PitchShifter.h"
#include "raspi_pitchshiftdeployment.h"
#include "rt_nonfinite.h"
#include <math.h>
#include <string.h>

/* Function Definitions */
void PitchShifter_stepImpl(audiopluginexample_PitchShifter *obj, double u[9600])
{
  double gains1[4800];
  double gains2[4800];
  double delays1[4800];
  double delays2[4800];
  double ph1;
  double ph2;
  double pstep;
  double ovrlp;
  double sd;
  double fgain;
  int i;
  double x;
  int ti;
  c_dspcodegen_VariableFractional *b_obj;
  static double dly[9600];
  dsp_VariableFractionalDelay_0 *c_obj;
  int b_index;
  int outOffset;
  int dlyIdx;
  int buffstart;
  int k;
  int buffIdx;
  int j;
  int ioIdx;
  int ti_tmp;
  static double delayedOut[19200];
  int filtIdx;
  memset(&gains1[0], 0, 4800U * sizeof(double));
  memset(&gains2[0], 0, 4800U * sizeof(double));
  memset(&delays1[0], 0, 4800U * sizeof(double));
  memset(&delays2[0], 0, 4800U * sizeof(double));
  if (!(obj->pRate == 0.0)) {
    ph1 = obj->Phase1State;
    ph2 = obj->Phase2State;
    pstep = obj->pPhaseStep;
    ovrlp = obj->Overlap;
    sd = obj->pSampsDelay;
    fgain = obj->pFaderGain;
    for (i = 0; i < 4800; i++) {
      x = ph1 + pstep;
      if (rtIsNaN(x) || rtIsInf(x)) {
        ph1 = rtNaN;
      } else if (x == 0.0) {
        ph1 = 0.0;
      } else {
        ph1 = fmod(x, 1.0);
        if (ph1 == 0.0) {
          ph1 = 0.0;
        } else {
          if (x < 0.0) {
            ph1++;
          }
        }
      }

      x = ph2 + pstep;
      if (rtIsNaN(x) || rtIsInf(x)) {
        ph2 = rtNaN;
      } else if (x == 0.0) {
        ph2 = 0.0;
      } else {
        ph2 = fmod(x, 1.0);
        if (ph2 == 0.0) {
          ph2 = 0.0;
        } else {
          if (x < 0.0) {
            ph2++;
          }
        }
      }

      if ((ph1 < ovrlp) && (ph2 >= 1.0 - ovrlp)) {
        delays1[i] = sd * ph1;
        delays2[i] = sd * ph2;
        gains1[i] = cos((1.0 - ph1 * fgain) * 3.1415926535897931 / 2.0);
        gains2[i] = cos((ph2 - (1.0 - ovrlp)) * fgain * 3.1415926535897931 / 2.0);
      } else if ((ph1 > ovrlp) && (ph1 < 1.0 - ovrlp)) {
        ph2 = 0.0;
        delays1[i] = sd * ph1;
        gains1[i] = 1.0;
        gains2[i] = 0.0;
      } else if ((ph1 >= 1.0 - ovrlp) && (ph2 < ovrlp)) {
        delays1[i] = sd * ph1;
        delays2[i] = sd * ph2;
        gains1[i] = cos((ph1 - (1.0 - ovrlp)) * fgain * 3.1415926535897931 / 2.0);
        gains2[i] = cos((1.0 - ph2 * fgain) * 3.1415926535897931 / 2.0);
      } else {
        if ((ph2 > ovrlp) && (ph2 < 1.0 - ovrlp)) {
          ph1 = 0.0;
          delays2[i] = sd * ph2;
          gains1[i] = 0.0;
          gains2[i] = 1.0;
        }
      }
    }

    obj->Phase1State = ph1;
    obj->Phase2State = ph2;
    for (ti = 0; ti < 4800; ti++) {
      dly[ti] = delays1[ti];
      dly[ti + 4800] = delays2[ti];
    }

    b_obj = &obj->pShifter;
    if (obj->pShifter.isInitialized != 1) {
      obj->pShifter.isSetupComplete = false;
      obj->pShifter.isInitialized = 1;
      obj->pShifter.isSetupComplete = true;
      c_obj = &obj->pShifter.cSFunObject;

      /* System object Initialization function: dsp.VariableFractionalDelay */
      b_obj->cSFunObject.W0_BUFF_OFFSET = 5760;
      b_obj->cSFunObject.W0_BUFF_OFFSET += 2;
      buffIdx = 0;
      for (i = 0; i < 11526; i++) {
        c_obj->W1_BUFF[buffIdx] = c_obj->P0_IC;
        buffIdx++;
      }
    }

    c_obj = &obj->pShifter.cSFunObject;

    /* System object Outputs function: dsp.VariableFractionalDelay */
    for (b_index = 0; b_index < 2; b_index++) {
      outOffset = 9600 * b_index;
      dlyIdx = 0;
      for (k = 0; k < 2; k++) {
        buffstart = c_obj->W0_BUFF_OFFSET;
        ioIdx = k * 4800;
        buffIdx = k * 5763;
        for (i = 0; i < 4800; i++) {
          ti_tmp = dlyIdx + 4800 * b_index;
          ti = (int)floor(dly[ti_tmp]);
          if (ti < 1) {
            ti = 1;
            pstep = 0.0;
          } else if (ti >= 5760) {
            ti = 5760;
            pstep = 0.0;
          } else {
            pstep = dly[ti_tmp] - (double)ti;
          }

          dlyIdx++;
          filtIdx = 0;
          ti_tmp = i - ti;
          for (j = 0; j < 4; j++) {
            ti = ti_tmp + 1;
            if (ti < 0) {
              ti += buffstart;
              if (ti < 0) {
                ti += 5763;
              }

              ph1 = c_obj->W1_BUFF[ti + buffIdx] * c_obj->P1_FilterArgs[filtIdx];
            } else {
              ph1 = u[ti + ioIdx] * c_obj->P1_FilterArgs[filtIdx];
            }

            ph2 = ph1;
            filtIdx++;
            if (ti_tmp < 0) {
              ti = ti_tmp + buffstart;
              if (ti < 0) {
                ti += 5763;
              }

              ph1 = c_obj->W1_BUFF[ti + buffIdx] * c_obj->P1_FilterArgs[filtIdx];
            } else {
              ph1 = u[ti_tmp + ioIdx] * c_obj->P1_FilterArgs[filtIdx];
            }

            ph2 += ph1;
            filtIdx++;
            ti = ti_tmp - 1;
            if (ti < 0) {
              ti += buffstart;
              if (ti < 0) {
                ti += 5763;
              }

              ph1 = c_obj->W1_BUFF[ti + buffIdx] * c_obj->P1_FilterArgs[filtIdx];
            } else {
              ph1 = u[ti + ioIdx] * c_obj->P1_FilterArgs[filtIdx];
            }

            ph2 += ph1;
            filtIdx++;
            ti = ti_tmp - 2;
            if (ti < 0) {
              ti += buffstart;
              if (ti < 0) {
                ti += 5763;
              }

              ph1 = c_obj->W1_BUFF[ti + buffIdx] * c_obj->P1_FilterArgs[filtIdx];
            } else {
              ph1 = u[ti + ioIdx] * c_obj->P1_FilterArgs[filtIdx];
            }

            ph2 += ph1;
            filtIdx++;
            c_obj->W2_PolyCoeffs[j] = ph2;
          }

          ph1 = c_obj->W2_PolyCoeffs[0];
          ph1 = ph1 * pstep + c_obj->W2_PolyCoeffs[1];
          ph1 = ph1 * pstep + c_obj->W2_PolyCoeffs[2];
          ph1 = ph1 * pstep + c_obj->W2_PolyCoeffs[3];
          delayedOut[(i + ioIdx) + outOffset] = ph1;
        }

        dlyIdx -= 4800;
      }
    }

    c_obj = &obj->pShifter.cSFunObject;

    /* System object Update function: dsp.VariableFractionalDelay */
    buffstart = b_obj->cSFunObject.W0_BUFF_OFFSET;
    for (j = 0; j < 2; j++) {
      buffIdx = j * 5763;
      ioIdx = j * 4800;
      buffstart = c_obj->W0_BUFF_OFFSET;
      for (i = 0; i < 4800; i++) {
        c_obj->W1_BUFF[buffstart + buffIdx] = u[i + ioIdx];
        if (buffstart < 5762) {
          buffstart++;
        } else {
          buffstart = 0;
        }
      }
    }

    b_obj->cSFunObject.W0_BUFF_OFFSET = buffstart;
    for (i = 0; i < 2; i++) {
      for (ti = 0; ti < 4800; ti++) {
        ti_tmp = ti + 4800 * i;
        delayedOut[ti_tmp] *= gains1[ti];
        ti_tmp += 9600;
        delayedOut[ti_tmp] *= gains2[ti];
      }
    }

    for (j = 0; j < 9600; j++) {
      u[j] = delayedOut[j];
      u[j] += delayedOut[j + 9600];
    }
  }
}

/* End of code generation (PitchShifter.c) */
