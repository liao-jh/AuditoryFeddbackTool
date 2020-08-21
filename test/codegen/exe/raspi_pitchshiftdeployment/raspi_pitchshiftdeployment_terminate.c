/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * raspi_pitchshiftdeployment_terminate.c
 *
 * Code generation for function 'raspi_pitchshiftdeployment_terminate'
 *
 */

/* Include files */
#include "raspi_pitchshiftdeployment_terminate.h"
#include "raspi_pitchshiftdeployment.h"
#include "raspi_pitchshiftdeployment_data.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void raspi_pitchshiftdeployment_terminate(void)
{
  /* user code (Terminate function Body) */
  {
    MW_killPyserver();
    mwRaspiTerminate();
  }

  isInitialized_raspi_pitchshiftdeployment = false;
}

/* End of code generation (raspi_pitchshiftdeployment_terminate.c) */
