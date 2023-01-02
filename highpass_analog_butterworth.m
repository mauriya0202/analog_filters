%To design an analog highpass butterworth filter

pr=input("Enter the pass band ripple in -ve dB:");
sa=input("Enter the stop band attenuation in -ve dB:");

fpb=input("Enter the pass band ripple frequency in Hz:");
fsb=input("Enter the stop band attenuation frequency in Hz:");

osb=2*pi*fsb; 
opb=2*pi*fpb; 

or=opb/osb;

N_num=log10((10^(-pr/10)-1)/(10^(-sa/10)-1));
N_den=2*(log10(1/or));

N=ceil(N_num/N_den);
%N=4


disp("N")
disp(N)

warning("off","all");

s=tf('s');
hsde=1;

%finding poles
for k=0:N-1
    sk(k+1)=exp(1j*pi/2)*exp(1j*pi*k/N)*exp(1j*pi/(2*N));
    hsde=hsde*(s-sk(k+1));
end

disp("poles sk")
disp(sk);

num=[1];
den=real(poly(sk));
HaSN=tf(num,den);
ocn=(1/(10^(-pr/10)-1))^(1/(2*N))

disp(ocn);
ocp=opb/ocn

%Analog Analog Transformation
[b,a]=lp2hp(num,den,ocp);
Hshighpass=tf(b,a)

freqs(b,a)