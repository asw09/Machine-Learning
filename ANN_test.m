function [ one_output_f1s, six_output_f1s ] = ANN_test()
%ANN_MAIN - Creates and tests a set of ANNs, then analyses and returns 
%           their results

    % Loads and transforms the examples from cleandata_students.txt
	[ex, tg]  = loaddata('cleandata_students.txt');
    [examples, targets] = ANNdata(ex,tg);
    single_results = zeros(size(tg));
    results = zeros(size(tg));

    % Epochs
    epochs = 100;
    
    % Do 10 fold cross evaluation...
    folds = 10;
    one_output_f1s = zeros(folds,1);
    six_output_f1s = zeros(folds,1);
    indices = crossvalind('Kfold',size(tg,1),folds);

    single_net = feedforwardnet([10,5],'trainbfg');
    single_net.divideFcn = 'dividerand';
    single_net.divideParam.trainRatio = 0.8;
    single_net.divideParam.testRatio = 0.0;
    single_net.divideParam.valRatio = 0.2;
    single_net.trainParam.epochs = epochs;
    single_net.layers{1}.transferFcn = 'purelin';
    single_net.layers{2}.transferFcn = 'purelin';
    single_net.trainParam.goal = 0;
    single_net.trainParam.showWindow = 0;
    
    net = feedforwardnet([5,14],'trainbfg');
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 0.8;
    net.divideParam.testRatio = 0.0;
    net.divideParam.valRatio = 0.2;
    net.trainParam.epochs = 100;
    net.layers{1}.transferFcn = 'purelin';
    net.layers{2}.transferFcn = 'purelin';
    net.trainParam.goal = 0;
    net.trainParam.showWindow = 0;

    num_per_fold = floor(size(ex,1) / folds);
    train_set_size = size(ex,1) - num_per_fold;
    test_set = zeros(size(examples,1),num_per_fold);
    train_set = zeros(size(examples,1),train_set_size);
    train_targets = zeros(size(targets,1),train_set_size);
    test_targets = zeros(num_per_fold,1);
    output_targets = zeros(size(tg));
    current_num = 1;

    for i = 1:folds
        end_fold = current_num + num_per_fold;
        test_num = 1;
        train_num = 1;
        for j = 1:size(examples,2)
            if (indices(j) == i)
                % Add this example to the test set
                test_set(:,test_num) = examples(:,j);
                test_targets(test_num) = tg(j);
                test_num = test_num + 1;
            else
                % Add the example to the training set
                train_set(:,train_num) = examples(:,j);
                train_targets(:,train_num) = targets(:,j);
                train_num = train_num + 1;
            end
        end
        
        % Generate the single six output ANN
        
        single_net = configure(single_net,train_set,train_targets);
        single_net = train(single_net,train_set,train_targets);
        single_res = sim(single_net,test_set);

        % Uncomment to show results for each fold
        [a,b,x] = evaluate_results(six_output_combine(single_res),test_targets);
        six_output_f1s(i) = x;
        
        % Generate the six single output ANNs
        

        % Anger
        emo_targets = train_targets(1,:);
        net = configure(net,train_set,emo_targets);
        net = train(net,train_set,emo_targets);
        anger_res = sim(net,test_set);
        
        % Disgust
        emo_targets = train_targets(2,:);
        net = configure(net,train_set,emo_targets);
        net = train(net,train_set,emo_targets);
        disg_res = sim(net,test_set);
        
        % Fear
        emo_targets = train_targets(3,:);
        net = configure(net,train_set,emo_targets);
        net = train(net,train_set,emo_targets);
        fear_res = sim(net,test_set);
        
        % Happiness
        emo_targets = train_targets(4,:);
        net = configure(net,train_set,emo_targets);
        net = train(net,train_set,emo_targets);
        happy_res = sim(net,test_set);
        
        % Sadness
        emo_targets = train_targets(5,:);
        net = configure(net,train_set,emo_targets);
        net = train(net,train_set,emo_targets);
        sad_res = sim(net,test_set);
        
        % Surprise
        emo_targets = train_targets(6,:);
        net = configure(net,train_set,emo_targets);
        net = train(net,train_set,emo_targets);
        surp_res = sim(net,test_set);
        
        % Combine the results and add them to the list
        fold_res = combine_probability(anger_res',disg_res',fear_res', ...
            happy_res',sad_res',surp_res');
        output_targets(current_num:(end_fold - 1)) = test_targets;
        single_results(current_num:(end_fold - 1)) = ...
            six_output_combine(single_res);
       results(current_num:(end_fold - 1)) = fold_res;
        current_num = end_fold;
        
        [a,b,x] = evaluate_results(fold_res,test_targets);
        one_output_f1s(i) = x;
        
    end
    
    disp('Six Output Tree Results:')
    evaluate_results(single_results,output_targets);
    disp(' ')
    disp('Single Output Tree Results:')
    evaluate_results(results,output_targets);
    plot((1:10),one_output_f1s,(1:10),six_output_f1s);

end
