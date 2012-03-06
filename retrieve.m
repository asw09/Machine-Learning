function [ similar_case ] = retrieve( trained_cbr,new_case )
% RETRIEVE - retrieves a similar case from a trained CBR system

    % *** RANDOM ALGORITHM ***
    % similar_case = CBR_retrieve_random(trained_cbr);
    
    % *** LENGTH OF AU VECTOR ALGORITHM ***
    % similar_case = CBR_retrieve_length(trained_cbr,new_case);
    
    % *** TOTAL MATCHES ALGORITHM ***
    % similar_case = CBR_retrieve_matches(trained_cbr,new_case);
     
    % *** TOTAL MATCHES/TOTAL SIZE ALGORITHM ***
     similar_case = CBR_retrieve_match_pc(trained_cbr,new_case); 
    

end