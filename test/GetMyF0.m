function F0 = GetMyF0(filename)
    [~, Fs] = audioread(filename);
    samples = [1 * Fs, 3 * Fs];
    
    %{
    [y, Fs] = audioread(filename, samples);
    dt = 1/Fs;
    I0 = round(0.1/dt);
    Iend = round(0.4/dt);
    x = y(I0:Iend);
    c = cceps(x);
    t = 0:dt:length(x) * dt - dt;

    trng = t(t>=2e-3 & t<=10e-3);
    crng = c(t>=2e-3 & t<=10e-3);

    [~, I] = max(crng);
    F0 = 1/trng(I);
    fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n', 1/trng(I))
    %}
    
    [x, Fs] = audioread(filename, samples);
    [b0,a0] = butter(2,325/(Fs/2));
    xin = abs(x);
    xin = filter(b0,a0,xin);
    xin = xin-mean(xin);
    x2 = zeros(length(xin),1);
    x2(1:length(x)-1) = xin(2:length(x));
    zc = length(find((xin>0 & x2<0) | (xin<0 & x2>0)));
    F0 = 0.5*Fs*zc/length(x);
    fprintf('Zero-crossing F0 estimate is %3.2f Hz.\n',F0)
    
end