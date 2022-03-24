% Same function as in "Code version 1"
function [policyA1, policyC] = getPolicy_analytical

global T beta r gamma
global numPtsA Agrid

% Initialise output arrays
policyC  = NaN(T, numPtsA);
policyA1 = NaN(T, numPtsA);

%% ------------------------------------------------------------------------ 
% Check lecture notes
alpha = (beta^(1/gamma))*((1+r)^((1-gamma)/gamma));

for ixt = 1:1:T
    periodsLeft = T- ixt + 1;    
    for ixA = 1:1:numPtsA
        
        if (abs(alpha - 1) < 1e-5) 
            policyC(ixt,ixA) =  Agrid(ixt,ixA) / periodsLeft;
        else           
            policyC(ixt,ixA) = ( (1-alpha) / (1-(alpha^periodsLeft)) ) * Agrid(ixt,ixA);
        end
                   
        policyA1(ixt,ixA) = (1+r) * (Agrid(ixt,ixA) - policyC(ixt,ixA));
    end    
end
        
end

