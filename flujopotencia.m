%-------------------------------------------%
% Comportamiento del flujo de potencia a    %
% través de una línea de transmisión.       %
%                                           %
% Realizado por: Alex Andrade               %
% Versión: 1.0                              %
% Fecha: 10/05/2022
%-------------------------------------------%

F=60;
wb = 2*pi*F;

R = input("Resistencia por unidad de logintud r = ");
I = input("Inductancia por unidad de logitud l = ");
C = input("Capacitancia por unidad de logitud c = ");
L = input("Longitud de la linea = ");
V1 = input("Mag. del voltaje del lado de despacho = ");
Vf1 = input("Fase del voltaje del lado de despacho = ");
V2 = input("Mag. del voltaje del lado de recepcion = ");
Vf2 = input("Fase del voltaje del lado de recepcion = ");

Z = R + 1j*wb*L; % Impedancia de la linea
Vf1 = Vf1*pi/180; %Conversion de Deg a Rad
Vf2 = Vf2*pi/180;

V1=V1.*cos(Vf1) + 1j*V1.*sin(Vf1);
V2=V2.*cos(Vf2) + 1j*V2.*sin(Vf2);

Vf12 = Vf1 - Vf2; % Angulo de potencia

Z_a = abs(Z);
Z_theta = angle(Z);

C1_1 = V1^2/Z_a;
C2_2 = V2^2/Z_a;
B_a = V1*V2/Z_a;

C1 = C1_1.*cos(Z_theta) + 1j*C1_1.*sin(Z_theta);
C2 = C2_2.*cos(Z_theta) + 1j*C2_2.*sin(Z_theta);
B = B_a.*cos(Z_theta) + 1j*B_a.*sin(Z_theta);

theta12 = 0:0.01:2*pi;
S12 = C1 - B.*exp(1j*theta12); %Potencia despachada
S21 = -C2 + B.*exp(-1j*theta12); %Potencia consumida

S12_p = C1 - B.*exp(1j*Vf12); %Potencia despachada para theta12
S21_p = C2 + B.*exp(-1j*Vf12); %Potencia consumida para theta12

P1 = real(S12_p); %Mag. de potencia despachada
P2 = real(S21_p); %Mag. de potencia consumida

figure;
plot(real(S12),imag(S12));
hold on
plot(real(S21),imag(S21));
hold on
title('Circulos de Potencia');
xlabel('P');
ylabel('Q');
legend('Circulo de Despacho','Circulo de Consumo');
grid on;

disp ('La Potencia despachada es: ');
P1
disp('La Potencia recibida es:');
P2
disp('El máximo ángulo de potencia es:');
disp(Z_theta)