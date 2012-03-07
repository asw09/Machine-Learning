function [ avg_f1 ] = CBR_test_retrieve( num_tests )
% CBR_TEST_RETRIEVE - run CBR_main <num_tests> times and find the average
%                     f1 measure from all the runs

    f1s = zeros(num_tests,1);
    for i = 1:num_tests
        f1s(i) = CBR_main();
    end
    avg_f1 = mean(f1s);
    disp('Average CBR System Results:')
    disp(avg_f1)

end