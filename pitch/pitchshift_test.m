[audioIn,fs] = audioread('3.wav');

audioOut = shiftPitch(audioIn,5,'LockPhase',true);
sound(audioIn,fs)
sound(audioOut,fs)