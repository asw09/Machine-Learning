function [ trained_cbr ] = CBRinit( examples,targets )
% CBRINIT - initialises a CBR system with a given set of examples

    trained_cbr = cell(size(examples,1),1);
    for i = 1:size(examples,1)
        new_case = CBR_get_case(examples(i,:),targets(i));
        trained_cbr{i} = new_case;
    end

end