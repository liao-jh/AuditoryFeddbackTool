/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * audioplayer.c
 *
 * Code generation for function 'audioplayer'
 *
 */

/* Include files */
#include "audioplayer.h"
#include "MW_AudioIO.h"
#include "raspi_pitchshiftdeployment.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void audioplayer_play(c_raspi_internal_codegen_audiop *obj, const short data
                      [9600])
{
  int i;
  char cv[11];
  static const char cv1[11] = "plughw:1,0";
  MW_Audio_Direction_Type audioDirection;
  int i1;
  if (obj->isInitialized != 1) {
    obj->isSetupComplete = false;
    obj->isInitialized = 1;
    audioDirection = MW_AUDIO_OUT;
    for (i1 = 0; i1 < 11; i1++) {
      cv[i1] = cv1[i1];
    }

    MW_AudioOpen(cv, 48000.0, 2.0, obj->QueueDuration, 4800.0, audioDirection);
    obj->isSetupComplete = true;
  }

  for (i = 0; i < 11; i++) {
    cv[i] = cv1[i];
  }

  MW_AudioWrite(cv, data);
}

/* End of code generation (audioplayer.c) */
