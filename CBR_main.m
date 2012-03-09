function [ avg_f1 ] = CBR_main( )
% CBR_MAIN - Performs 10-fold cross-validation on a Case Based Resoning
%            system and outputs the results

    % Loads and transforms the examples from cleandata_students.txt
	[examples, targets]  = loaddata('cleandata_students.txt');
    %[examples, targets]  = loaddata('noisydata_students.txt');
    fclose('all');
    results = zeros(size(targets));
    
    % Do 10 fold cross evaluation...
    folds = 10;
    indices = crossvalind('Kfold',size(targets,1),folds);

    % Preallocate testing/training vectors for speed
    num_per_fold = floor(size(examples,1) / folds);
    train_set_size = size(examples,1) - num_per_fold;
    test_set = zeros(num_per_fold,size(examples,2));
    train_set = zeros(train_set_size,size(examples,2));
    train_targets = zeros(train_set_size,1);
    test_targets = zeros(num_per_fold,1);
    output_targets = zeros(size(targets));
    current_num = 1;

    for i = 1:folds
        end_fold = current_num + num_per_fold;
        test_num = 1;
        train_num = 1;
        for j = 1:size(examples,1)
            if (indices(j) == i)
                % Add this example to the test set
                test_set(test_num,:) = examples(j,:);
                test_targets(test_num) = targets(j);
                test_num = test_num + 1;
            else
                % Add the example to the training set
                train_set(train_num,:) = examples(j,:);
                train_targets(train_num) = targets(j);
                train_num = train_num + 1;
            end
        end
        
        % Initialise the CBR system with the training set
        trained_cbr = CBRinit(train_set,train_targets);
        fold_res = testCBR(trained_cbr,test_set);
        
        % Add the results to the result vector
   output_targets(current_num:(current_num + length(test_targets) - 1))...
            = test_targets;
        results(current_num:(current_num + length(fold_res) - 1)) = fold_res;
        % Uncomment to display results for each fold
        %evaluate_results(fold_res,test_targets);
        current_num = end_fold;
        
    end
    
    disp('CBR System Results:')
    [~,~,avg_f1] = evaluate_results(results,output_targets);

end
