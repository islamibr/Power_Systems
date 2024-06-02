clc;
close all;

% system parameters prompt
prompt = {'Diameter (cm): ','Length (km): ','Resistivity (Ohm.m): ', 'Frequency (Hz): ' , 'Receiving Voltage (kV): '};
dlgtitle = 'Power System Project';
dims = [1 35];
answer = inputdlg(prompt,dlgtitle,dims);
answer = str2double(answer);
% system type prompt
button_options = {'Symmetric', 'Asymmetric', 'Cancel'};

% Display menu
choice = menu('Power System Project', button_options);

% Process user choice
switch choice
    case 1
        system_type = 'Symmetric'; % Update system_type based on user choice
    case 2
        system_type = 'Asymmetric'; % Update system_type based on user choice
    case 3
        disp('User canceled the dialog');
        return; % Exit the script if the user cancels
end

% Get user inputs
diameter_cm = answer(1);
len = answer(2);
resistivity = answer(3);
frequency = answer(4);
V_r_input = answer(5); 
V_r = V_r_input / sqrt(3) ; 

% Perform functions
[R_total, L_total, C_total] = calculate_RLC_parameters(diameter_cm, len, resistivity, system_type);
[A, B, C, D] = calculate_ABCD_parameters(R_total, L_total, C_total, len, frequency);
calculate_transmission_line_performance(A, B, C, D, V_r);