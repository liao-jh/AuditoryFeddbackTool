/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * raspi_pitchshiftdeployment_types.h
 *
 * Code generation for function 'raspi_pitchshiftdeployment_types'
 *
 */

#ifndef RASPI_PITCHSHIFTDEPLOYMENT_TYPES_H
#define RASPI_PITCHSHIFTDEPLOYMENT_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#include "MW_AudioIO.h"

/* Type Definitions */
#ifndef typedef_dsp_VariableFractionalDelay_0
#define typedef_dsp_VariableFractionalDelay_0

typedef struct {
  int S0_isInitialized;
  int W0_BUFF_OFFSET;
  double W1_BUFF[11526];
  double W2_PolyCoeffs[4];
  int W3_PrevNumTaps;
  int W4_PrevNumChan;
  double P0_IC;
  double P1_FilterArgs[16];
} dsp_VariableFractionalDelay_0;

#endif                                 /*typedef_dsp_VariableFractionalDelay_0*/

#ifndef typedef_c_dspcodegen_VariableFractional
#define typedef_c_dspcodegen_VariableFractional

typedef struct {
  bool matlabCodegenIsDeleted;
  int isInitialized;
  bool isSetupComplete;
  dsp_VariableFractionalDelay_0 cSFunObject;
} c_dspcodegen_VariableFractional;

#endif                                 /*typedef_c_dspcodegen_VariableFractional*/

#ifndef typedef_audiopluginexample_PitchShifter
#define typedef_audiopluginexample_PitchShifter

typedef struct {
  bool matlabCodegenIsDeleted;
  double PrivateSampleRate;
  int isInitialized;
  bool isSetupComplete;
  bool TunablePropsChanged;
  double PitchShift;
  double Overlap;
  double Phase1State;
  double Phase2State;
  double pRate;
  double pSampsDelay;
  c_dspcodegen_VariableFractional pShifter;
  double pPhaseStep;
  double pFaderGain;
} audiopluginexample_PitchShifter;

#endif                                 /*typedef_audiopluginexample_PitchShifter*/

#ifndef typedef_c_raspi_internal_codegen_audioc
#define typedef_c_raspi_internal_codegen_audioc

typedef struct {
  bool matlabCodegenIsDeleted;
  int isInitialized;
  bool isSetupComplete;
  double QueueDuration;
} c_raspi_internal_codegen_audioc;

#endif                                 /*typedef_c_raspi_internal_codegen_audioc*/

#ifndef typedef_c_raspi_internal_codegen_audiop
#define typedef_c_raspi_internal_codegen_audiop

typedef struct {
  bool matlabCodegenIsDeleted;
  int isInitialized;
  bool isSetupComplete;
  double QueueDuration;
} c_raspi_internal_codegen_audiop;

#endif                                 /*typedef_c_raspi_internal_codegen_audiop*/
#endif

/* End of code generation (raspi_pitchshiftdeployment_types.h) */
