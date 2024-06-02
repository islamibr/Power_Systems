function calculate_transmission_line_performance(A, B, C, D, V_r)
        dlgtitle = 'Power System Project';
        prompt = 'Choose model:';
        model_choice = questdlg(prompt, dlgtitle, 'Case 1', 'Case 2', 'Case 1');
        
        if isempty(model_choice)
            % User closed the dialog
            return;
        end

        if strcmp(model_choice, 'Case 1')
                     Pr = 0: 1000: 100000;
                        Sr = Pr / (0.8) * exp(1i * acos(0.8));
                        Ir = conj(Sr / (3 * V_r));
        
                        Vs = A * V_r + B * Ir;
                        Is = C * V_r + D * Ir;
        
                        Vreg = (abs(Vs / A) - abs (V_r)) / abs (V_r);
                    Ps= 3 * abs(Vs) .* abs(Is) .* cos(angle (Vs .* conj(Is)))*2/3;
                    eff=Pr ./ Ps;
                    figure;
                    plot(Pr,eff*100);
                    ylabel('Efficiency')
                    xlabel('Power receivied ')
                    ylim([0 100]);
                    grid on
                    
                    figure;
                    plot(Pr,Vreg*100);
                    grid on
                       
        else
                    %Leading Power Factors
                    Pr=100000;
                    pf = linspace (0.3,1,100); 
                    Sr1 = Pr ./ (pf) .* exp(1i * acos(pf));
                    Ir1 = conj(Sr1 / (3 * V_r));
        
                    Vs1 = A * V_r+ B * Ir1;
                    Is1 = C * V_r+ D * Ir1;
        
                    Ps1 = 3 * abs(Vs1) .* abs(Is1) .* cos(angle(Vs1 .* conj(Is1)));
        
                    Vreg1 = ((abs(Vs1 / A) - abs(V_r)) / abs(V_r)) * 100;
                    eff1 = (Pr ./ Ps1) * 100;
        
                    %Leading Power Factors
                    Sr2 = Pr ./ (pf) .* exp(1i * -acos(pf));    
                    Ir2 = conj(Sr2 / (3 * V_r));
        
                    Vs2 = A * V_r+ B * Ir2;
                    Is2 = C * V_r+ D * Ir2;
        
                    Vreg2 = ((abs(Vs2 / A) - abs(V_r)) / abs(V_r)) * 100;
                    Ps2 = 3 * abs(Vs2) .* abs (Is2) .* cos (angle (Vs2 .* conj(Is2)));
                    eff2 = (Pr ./ Ps2) * 100;
                    figure;
                    subplot(2,1,1);
                    title('Efficiency')
                    plot(pf, eff1)
                    grid on
                    ylabel('Efficiency')
                    xlabel('Power Factor - Lagging')
                    subplot(2,1,2);
                    title('Voltage Regulation')
                    plot(pf, Vreg1);
                    grid on
                    ylabel('Voltage Regulation')
                    xlabel('Power Factor - Lagging')
                    
                    
                    figure;
                    subplot(2,1,1);
                    title('Efficiency')
                    plot(pf, eff2)
                    grid on
                    ylabel('Efficiency')
                    xlabel('Power Factor - Leading')
                    subplot(2,1,2);
                    title('Voltage Regulation')
                    plot(pf, Vreg2);
                    grid on
                    ylabel('Voltage Regulation')
                    xlabel('Power Factor - Leading')          
        end 
end