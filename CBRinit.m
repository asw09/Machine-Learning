function [ trained_cbr ] = CBRinit( examples,targets )
% CBRINIT - initialises a CBR system with a given set of examples

    trained_cbr = {};
    for i = 1:size(examples,1)
        new_case = CBR_get_case(examples(i,:),targets(i));
        trained_cbr = retain(trained_cbr,new_case,1);
    end

end