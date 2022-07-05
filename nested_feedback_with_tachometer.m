%System with constant feedback nested in unity feedback with tachometer
%G(s) = 10/s+1 
%Tachometer adds pole to origin (increase system type #)
syms s
k = sqrt(10)/11;
t = 0:01:8;
%Characteristic equation without tachometer feedback part
c_eq = [1 k*11 10];
%Closed-loop transfer function without tachometer feedback part
H = tf([0 0 10], [1 11*k 10]);
%undamped natural freq; damping ratio 
[wn, zeta] = damp(H);
%Closed-loop tf of whole system
H_sym = 10/(s^3+k*11*s^2+10*s);
%inverse laplace of H_sym
h1 = ilaplace(H_sym);
figure(1)
%Step response time domain equation
ezplot(h1, t);
%Partial fraction expansion for h2 (same as h1 different method)
[r, p, k] = residue([0 0 0 10],[1 11*k 10 0]);

%Partial fractions
T1 = r(1)/(s-p(1));
T2 = r(2)/(s-p(2));
T3 = r(3)/(s-p(3));

%Partial fractions inverse laplace
t1 = ilaplace(T1);
t2 = ilaplace(T2);
t3 = ilaplace(T3);

%Step response time domain equation
h2 = t1+t2+t3;
figure(2)
ezplot(h2,t);

%Differentiate to analyze overshoot
h2_diff = diff(h2);
figure(3);
ezplot(h2_diff, t);
%Pole-zero map of system
figure(4);
pzmap(H)
grid on
