%To design an analog bandstop chebyshev filter

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

A=(o1*(ou-ol))/(-(o1^2)+(ou*ol));
B=(o2*(ou-ol))/(-(o2^2)+(ou*ol));
or=min(abs(A),abs(B));

p=sqrt(10^(-sa/10)-1);
q=sqrt(10^(-pr/10)-1);

eps=sqrt(10^(-pr/10)-1);
%a=10^(-sa/20);
%g=sqrt((a^2-1)/(eps^2));

%N=ceil((log10(g+sqrt(g^2-1)))/log10(or+sqrt(or^2-1)))

N_num=acosh(p/q);
N_den=acosh(or);

N=ceil(N_num/N_den);
%N=3

disp(N)

hsde=1;
s=tf('s');

theta=(1/N)*asinh(1/eps);

for k=1:N
    phik=((2*k-1)*pi)/(2*N);
    sk(k)=-sinh(theta)*sin(phik)+j*cosh(theta)*cos(phik);
    hsde=hsde*(s-sk(k));
end

disp("poles sk")
disp(sk);
den=real(poly(sk));

b0=den(N+1);
if (mod(N,2)==0)
    k0=b0/sqrt(1+(eps^2));
else
    k0=b0;
end
num=[k0];


HaSN=tf(num,den);
ocn=(1/((10^(-pr/10)-1))^(1/(2*N)))

disp(ocn);

%Analog Analog Transformation
ocf=sqrt(ol*ou) %center frequency
obw=ou-ol;
[b,a]=lp2bp(num,den,ocf,obw);
Hsbandpass=tf(b,a)

freqs(b,a)