function [ trained_cbr ] = CBRinit( examples,targets )
% CBRINIT - initialises a CBR system with a given set of examples

    trained_cbr = cell(7,1);
    for i = 1:size(examples,1)
        new_case = CBR_get_case(examples(i,:),targets(i));
        trained_cbr = retain(trained_cbr,new_case,1);
    end
%     total = 0;
%     for j = 1:10
%         for i = 1:size(trained_cbr,1)
%             if (size(trained_cbr{i}.active_aus,1) == j)
%                total = total + 1; 
%             end
%         end
%         fprintf('%d examples of size %d\n',total,j)
%         total = 0;
%     end
    % Sort the trained CBR system by typicality of cases
    for index = 1:7
        %matr = cell2mat(trained_cbr{index});
        if (size(trained_cbr{index},1) > 0)
            [~,order] = sort([trained_cbr{index}.typicality],'descend');
            trained_cbr{index} = trained_cbr{index}(order);
        end
    end
end