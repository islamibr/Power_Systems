function [A, B, C, D] = calculate_ABCD_parameters(R, L, C1, len, f)
    title = '';
    Y = 1i * 2 * pi * f * C1;
    Z = R + 1i * 2 * pi * f * L;
    if len >= 80 && len <= 250
        calculate_medium_line_parameters(Z,Y);
        line_type = "Meduim Line";
    else
        calculate_short_line_parameters(Z);
        line_type = "Short Line";
    end
    D = A;

    function calculate_medium_line_parameters(Z,Y)
        dlgtitle = 'Power System Project';
        prompt = 'Choose model:';
        model_choice = questdlg(prompt, dlgtitle, 'T', 'Pi', 'T');
        
        if isempty(model_choice)
            % User closed the dialog
            return;
        end
        
        % Calculate ABCD parameters for medium line based on the selected model
        t1 = 1 + Z*Y/2;
        t2 = 1 + Z*Y/4;
        if strcmp(model_choice, 'T')
            A = t1;
            B = Z.*t2;
            C = Y;
            title= 'T-model';
        else
            A = t1;
            B = Z;
            C = Y.*t2;
            title= 'Pi-model';
        end
    end

    function calculate_short_line_parameters(Z)
        % Calculate ABCD parameters for short line
        A = 1;
        B = Z;
        C = 0;
        title= 'Short-model';
    end

    fprintf('Model: Medium Line - %s\n', title);
    fprintf('A parameter: %f + %fi \n', real(A), imag(A));
    fprintf('B parameter: %f + %fi Ohm\n', real(B), imag(B));
    fprintf('C parameter: %f + %fi Siemens\n', real(C), imag(C));
    fprintf('D parameter: %f + %fi \n', real(D), imag(D));
   
    ABCD = sprintf('Line Type: %s\n A: %f + %fi \n B: %f + %fi  Ohm\n C: %f + %fi  Siemens\n D: %f + %fi',line_type, real(A),imag(A), real(B),imag(B), real(C),imag(C), real(D),imag(D));
    msgbox(ABCD, 'A B C D constants');


end