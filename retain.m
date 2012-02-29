function [ updated_cbr ] = retain( trained_cbr,solved_case )
% RETAIN - adds a solved case to the existing CBR system

    updated_cbr = vertcat(trained_cbr,solved_case);

end
