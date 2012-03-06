function [ avg_f1 ] = CBR_main( )
% CBR_MAIN - Performs 10-fold cross-validation on a Case Based Resoning
%            system and outputs the results

    % Loads and transforms the examples from cleandata_students.txt
	[examples, targets]  = loaddata('cleandata_students.txt');
    fclose('all');
    results = zeros(size(targets));
    match_stats = cell(size(targets,1),1); 
    
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
        output_targets(current_num:(end_fold - 1)) = test_targets;
        index = 1;
        for j = current_num:(end_fold - 1)
           results(j) = fold_res{index}.label;
           match_stats{j}.label = fold_res{index}.label;
           match_stats{j}.matches = fold_res{index}.matches;
           match_stats{j}.percentage = fold_res{index}.percentage;
           match_stats{j}.result = test_targets(index);
           index = index + 1;
        end
        %results(current_num:(end_fold - 1)) = fold_res;
        current_num = end_fold;
        
    end
    
%    for i = 1:size(match_stats,1)
%        if ~(match_stats{i}.label == match_stats{i}.result)
%            fprintf('PC: %f ',match_stats{i}.matches)
%            fprintf('PC2: %f, correct result is %d ', ...
%                match_stats{i}.percentage, ...
%                match_stats{i}.result)
%            fprintf('Predicted: %d\n', match_stats{i}.label)
%        end
%    end
    disp('CBR System Results:')
    [~,~,avg_f1] = evaluate_results(results,output_targets);

end