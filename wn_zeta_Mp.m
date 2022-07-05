syms s
t = 0:0.01:4;
%Open-loop transfer function
G = tf([0 0 10],[1 1 0]);
%Closed-loop transfer function
H = tf([0 0 10], [1 1 10]);
%Laplace transform of y
Y_s = 10/(s^3 + s^2 +10*s);
%Undamped natural frequency; Damping ratio 
[wn, zeta] = damp(H);
figure(1);
%Pole-zero map of H(s)
pzmap(H);
grid on;
%Partial fraction expansion coefficients 
[r, p, k] = residue([0 0 0 10],[1 1 10 0]);
%Time-domain step response
y_s = ilaplace(Y_s);
figure(2);
%Plot y; look at steady state response
ezplot(y_s, [0 10 -5 5]);
%Examine 1st derivative to find %-overshoot (y_s(t) when y_s'(t)=0)
y_sprime = diff(y_s);