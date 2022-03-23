% This function gets analytical policy functions in a world where 
% (1) there is no uncertainty
% (2) borrowing is allowed up to the natural borrowing constraint

function [ policyA1, policyC ] = getPolicy_analytical

%% ------------------------------------------------------------------------ 
% Global variables that we need to access
global T beta r gamma
global numPtsA Agrid

%% ------------------------------------------------------------------------ 
% Initialize output arrays
policyC = NaN(T, numPtsA);
policyA1 = NaN(T, numPtsA);

%% ------------------------------------------------------------------------ 
% Suggestion: take a look to the notes to better understand the following

alpha = (beta^(1/gamma))*((1+r)^((1-gamma)/gamma));

for ixt = 1:1:T
    periodsLeft = T- ixt + 1;    
    for ixA = 1:1:numPtsA
        
        if (abs(alpha - 1) < 1e-5) % if alpha is equal or close to 1, then optimal c is constant over time (see red dashed line in the graph on the slides)
            policyC(ixt,ixA) =  Agrid(ixt,ixA) / periodsLeft;
        else           
            policyC(ixt,ixA) = ( (1-alpha) / (1-(alpha^periodsLeft)) ) * Agrid(ixt,ixA);
        end
                   
        policyA1(ixt,ixA) = (1+r) * (Agrid(ixt,ixA) - policyC(ixt,ixA));
    end    
end
        
end

