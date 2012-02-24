function [ single_net, a_net, d_net, f_net, h_net, sa_net, su_net ] = ...
    ANN_generate()

    % Loads and transforms the examples from cleandata_students.txt
	[ex, tg]  = loaddata('cleandata_students.txt');
    [examples, targets] = ANNdata(ex,tg);

    % Epochs
    epochs = 100;

    % Generate the single six output ANN
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

    single_net = configure(single_net,examples,targets);
    single_net = train(single_net,examples,targets);
    single_res = sim(single_net,examples);
    
    % Generate the six single output ANNs
    net = feedforwardnet([8,4],'trainbfg');
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 0.8;
    net.divideParam.testRatio = 0.0;
    net.divideParam.valRatio = 0.2;
    net.trainParam.epochs = epochs;
    net.layers{1}.transferFcn = 'purelin';
    net.layers{2}.transferFcn = 'purelin';
    net.trainParam.goal = 0;
    net.trainParam.showWindow = 0; 

    % Anger
    emo_targets = targets(1,:);
    net = configure(net,examples,emo_targets);
    net = train(net,examples,emo_targets);
    anger_res = sim(net,examples);
    a_net = net;

    % Disgust
    emo_targets = targets(2,:);
    net = configure(net,examples,emo_targets);
    net = train(net,examples,emo_targets);
    disg_res = sim(net,examples);
    d_net = net;

    % Fear
    emo_targets = targets(3,:);
    net = configure(net,examples,emo_targets);
    net = train(net,examples,emo_targets);
    fear_res = sim(net,examples);
    f_net = net;

    % Happiness
    emo_targets = targets(4,:);
    net = configure(net,examples,emo_targets);
    net = train(net,examples,emo_targets);
    happy_res = sim(net,examples);
    h_net = net;

    % Sadness
    emo_targets = targets(5,:);
    net = configure(net,examples,emo_targets);
    net = train(net,examples,emo_targets);
    sad_res = sim(net,examples);
    sa_net = net;

    % Surprise
    emo_targets = targets(6,:);
    net = configure(net,examples,emo_targets);
    net = train(net,examples,emo_targets);
    surp_res = sim(net,examples);
    su_net = net;
    
    disp('Six Output Tree Results:')
    [x,y,avgf6] = evaluate_results(six_output_combine(single_res),tg);
    disp(' ')
    results = combine_probability(anger_res',disg_res',fear_res', ...
            happy_res',sad_res',surp_res');
    disp('Single Output Tree Results:')
    [x,y,avgf1] = evaluate_results(results,tg);

end

