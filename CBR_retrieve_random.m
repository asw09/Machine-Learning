function [ similar_case ] = CBR_retrieve_random( trained_cbr )
% CBR_RETRIEVE_RANDOM - retrieves a case from a trained CBR system at
%                       random (to be used as a control for other
%                       algorithms)

     similar_case = trained_cbr{unidrnd(size(trained_cbr,1))};    

end