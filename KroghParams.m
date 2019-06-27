%%
% Brian Hong 6-19-19
%
% File determines parameters for the Krogh cylinder model of oxygen
% transport used in Mcguire, Secomb (2001)
%

clear('prm') % storage for params

% param = value % Units | Description
prm.Pb = 100; % Torr | Average partial pressure of oxygen in blood at capillary entrance 
prm.P50 = 26; % Torr | Half-maximal hemoglobin saturation
prm.n = 2.7; % - | Hill equation exponent
prm.Cb = 0.2; % cm^3 O_2/cm^3 blood | Oxygen carrying capacity of blood
prm.Sh = 2.5; % - | Sherwood number
prm.Kpl = 8.3e-10; % (cm^2/s)[cm^3 O_2 /(cm^3*Torr)] | Krogh diffusion constant in plasma

% prm.Vbar = 2.25; % mm/s | Average blood flow
prm.Vbar = 2.25e-1; % cm/s | Average blood flow
% prm.Vbar = 3.49e-1; % cm/s | Average blood flow
prm.K = 9.4e-10; % (cm^2/s)[cm^3 O_2 /(cm^3*Torr)] | Krogh diffusion constant in tissue

% NOTE: In the text [M0] are is listed as cm^3 *100 cm^3/min, but should be
% listed as cm^3/(100 cm^3 * min )
% prm.M0 = 40; % cm^3 O_2 (100 cm^3*min) | Oxygen demand 
prm.M0 = 40/6000; % cm^3 O_2 / ( cm^3*s ) | Oxygen demand

prm.P0 = 1; % Torr | Half-maximal oxygen consumption
prm.Dmb = 1.73e-7; % cm^2/s | Myoglobin diffusion coefficient
prm.Cmb = 3.83e-7; % mol/cm^3 | Concentration of myoglobin
prm.P50mb = 3.2; % Torr | Pressure where myoglobin 50% saturated with Oxygen

prm.Vm = 2.24e4; % cm^3 | Molar volume
prm.Mt = 6.52e-9;% (cm^2/s)[cm^3 O_2 /(cm^3*Torr)] | Mass transfer coef

% From the text
% prm.Rc = 2.5; % microns | Capillary radius
% prm.L = 0.5; % mm | Capillary length
% prm.Rt = 26; % microns | Tissue Cylinder radius

% Converted to consistent units
prm.Rc = 2.5e-4; % cm | Capillary radius
prm.L = 0.5e-1; % cm | Capillary length
prm.Rt = 26e-4; % cm| Tissue Cylinder radius


% Numerical params
prm.Nz = 50;
prm.Nr = 100;




