function out=derivate_better(vec) 
    d = designfilt('differentiatorfir','FilterOrder',50, ...
        'PassbandFrequency',10,'StopbandFrequency',20, ...
        'SampleRate',500);
    dt=0.002;
    filter(d,vec)/dt;
    out=filter(d,vec)/dt;
end