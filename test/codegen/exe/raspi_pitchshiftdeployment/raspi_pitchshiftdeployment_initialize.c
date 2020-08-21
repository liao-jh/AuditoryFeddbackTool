/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * raspi_pitchshiftdeployment_initialize.c
 *
 * Code generation for function 'raspi_pitchshiftdeployment_initialize'
 *
 */

/* Include files */
#include "raspi_pitchshiftdeployment_initialize.h"
#include "raspi_pitchshiftdeployment.h"
#include "raspi_pitchshiftdeployment_data.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void raspi_pitchshiftdeployment_initialize(void)
{
  rt_InitInfAndNaN();

  /* user code (Initialize function Body) */
  {
    mwRaspiInit();
    MW_launchPyserver();
  }

  isInitialized_raspi_pitchshiftdeployment = true;
}

/* End of code generation (raspi_pitchshiftdeployment_initialize.c) */
