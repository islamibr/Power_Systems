function [R_ac, L_total, C_total] = calculate_RLC_parameters(diameter_cm, len, resistivity, system_type)
    % Constants
    permittivity = 8.854e-12; % F/m
    GMR_factor = 0.7788;
    inductance_factor = 2e-7; % Henry/m

    % Convert diameter from cm to meters
    diameter = diameter_cm * 0.01;

    % Calculating Area and Resistance
    area = pi * (diameter / 2)^2;
    R_total = resistivity * (len*1000 / area);
    R_ac = 1.1 * R_total;

    % Calculate D based on system symmetry
    if strcmp(system_type, 'Symmetric')
        % Symmetric System Input
        % system type prompt
        prompt_type = {'Enter spacing distance (meters): '};
        dlgtitle = 'Power System Project';
        dims = [1 35];
        answer_D = inputdlg(prompt_type,dlgtitle,dims);
        answer_D = str2double(answer_D);
        D = answer_D(1);
    else
        % Asymmetric System Input
        prompt = {'Enter the distance between phase A and B (meters): ','Enter the distance between phase B and C (meters): ','Enter the distance between phase C and A (meters): '};
        dlgtitle = 'Power System Project';
        dims = [1 55];
        answer = inputdlg(prompt,dlgtitle,dims);
    % gathering values
        Dab = str2double(answer(1));
        Dbc = str2double(answer(2));
        Dca =  str2double(answer(3));
        D = (Dab * Dbc * Dca)^(1/3); % Equivalent spacing for unsymmetrical system
    end

    % Calculating GMR and Inductance
    GMR = GMR_factor * (diameter / 2);
    L_phase = inductance_factor * log(D / GMR);
    L_total =  L_phase * len * 1000;

    % Calculating Capacitance
    C_phase = (2 * pi * permittivity) / log(2 * D / diameter);
    C_total =  C_phase * len * 1000;

    fprintf('Parameters:\n');
    fprintf('AC Resistance: %f Ohm\n', R_ac);
    fprintf('Total Inductance: %f H\n', L_total);
    fprintf('Total Capacitance: %f F\n', C_total);
    % POP UP MESSAGE OF VALUES 
    calcs = sprintf(' AC Resistance(Ohm): %f \n Total Inductance(H): %e \n Total Capacitance(F): %e', real(R_ac), real(L_total), real(C_total));
    msgbox(calcs, 'RLC parameters');

end