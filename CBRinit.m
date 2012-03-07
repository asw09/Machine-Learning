function [ trained_cbr ] = CBRinit( examples,targets )
% CBRINIT - initialises a CBR system with a given set of examples

    trained_cbr = cell(7,1);
    for i = 1:size(examples,1)
        new_case = CBR_get_case(examples(i,:),targets(i));
        trained_cbr = retain(trained_cbr,new_case,1);
    end
    
    % Sort the trained CBR system branches by typicality of cases
    for index = 1:7
        if (size(trained_cbr{index},1) > 0)
            [~,order] = sort([trained_cbr{index}.typicality],'descend');
            trained_cbr{index} = trained_cbr{index}(order);
        end
    end
    
end