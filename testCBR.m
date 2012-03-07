function [ results ] = testCBR( trained_cbr,test_set )
% TESTCBR - generates a vector of predictions for a set of examples

    results = zeros(size(test_set,1),1);
    for i = 1:size(test_set,1)
        new_case = CBR_get_case(test_set(i,:),0);
        similar_case = retrieve(trained_cbr,new_case);
        solved_case = reuse(similar_case,new_case);
        trained_cbr = retain(trained_cbr,solved_case,0);
        results(i) = solved_case.label;
    end

end