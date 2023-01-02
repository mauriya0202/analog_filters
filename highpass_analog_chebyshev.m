%To design an analog highpass chebyshev filter

pr=input("Enter the pass band ripple in -ve dB:");
sa=input("Enter the stop band attenuation in -ve dB:");

fpb=input("Enter the pass band ripple frequency in Hz:");
fsb=input("Enter the stop band attenuation frequency in Hz:");

osb=2*pi*fsb; 
opb=2*pi*fpb; 

or=opb/osb;

p=sqrt(10^(-sa/10)-1)
q=sqrt(10^(-pr/10)-1)

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

for k=0:N-1
    phik=((2*k-1)*pi)/(2*N);
    sk(k+1)=-sinh(theta)*sin(phik)+j*cosh(theta)*cos(phik);
    hsde=hsde*(s-sk(k+1));
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
%ocp=ocn*opb

%Analog Analog Transformation
[b,a]=lp2hp(num,den,opb);
Hshighpass=tf(b,a)

freqs(b,a)