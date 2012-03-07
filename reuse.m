function [ solved_case ] = reuse( similar_case,new_case )
% REUSE - attaches solution of similar_case to new_case

    solved_case.active_aus = new_case.active_aus;
    solved_case.label = similar_case.label;
    solved_case.typicality = 1;

end
