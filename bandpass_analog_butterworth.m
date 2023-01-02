%To design an analog bandpass butterworth filter

f1=input("Enter stop band attenuation frequency 1:");
f2=input("Enter stop band attenuation frequency 2:");
fl=input("Enter pass band ripple frequency 1:");
fu=input("Enter pass band ripple frequency 1:");

pr=input("Enter pass band ripple in -ve dB:");
sa=input("Enter stop band attenuation in -ve dB:");

o1=2*pi*f1;
o2=2*pi*f2;
ol=2*pi*fl;
ou=2*pi*fu;

A=(-(o1^2)+(ou*ol))/(o1*(ou-ol));
B=((o2^2)-(ou*ol))/(o2*(ou-ol));
or=min(abs(A),abs(B));

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

%Analog Analog Transformation
ocf=sqrt(ol*ou) %center frequency
obw=ou-ol;
[b,a]=lp2bp(num,den,ocf,obw);
Hsbandpass=tf(b,a)

freqs(b,a)