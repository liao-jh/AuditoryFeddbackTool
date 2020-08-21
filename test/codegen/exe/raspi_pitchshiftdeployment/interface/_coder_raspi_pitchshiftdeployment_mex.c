/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_raspi_pitchshiftdeployment_mex.c
 *
 * Code generation for function '_coder_raspi_pitchshiftdeployment_mex'
 *
 */

/* Include files */
#include "_coder_raspi_pitchshiftdeployment_mex.h"
#include "_coder_raspi_pitchshiftdeployment_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void c_raspi_pitchshiftdeployment_me(int32_T nlhs, int32_T
  nrhs);

/* Function Definitions */
void c_raspi_pitchshiftdeployment_me(int32_T nlhs, int32_T nrhs)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 0) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 0, 4,
                        26, "raspi_pitchshiftdeployment");
  }

  if (nlhs > 0) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 26,
                        "raspi_pitchshiftdeployment");
  }

  /* Call the function. */
  raspi_pitchshiftdeployment_api(nlhs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  (void)plhs;
  (void)prhs;
  mexAtExit(&raspi_pitchshiftdeployment_atexit);

  /* Module initialization. */
  raspi_pitchshiftdeployment_initialize();

  /* Dispatch the entry-point. */
  c_raspi_pitchshiftdeployment_me(nlhs, nrhs);

  /* Module termination. */
  raspi_pitchshiftdeployment_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_raspi_pitchshiftdeployment_mex.c) */
