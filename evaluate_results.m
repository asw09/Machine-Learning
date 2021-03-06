function [ x,y,avgf1 ] = evaluate_results( results,targets )
%
%EVALUATE_RESULTS - evaluates a set of results against a set of target values
%
%IN:  results: array of results from an experiment
%     targets: actual target values
%OUT: x: 6 x 6 confusion matrix
%     y: precision/recall table

[x,u] = confusion_matrix(results,targets);
y = precision_recall(x,targets);
disp(' ')
disp('                  Confusion Matrix')
display_confusion_matrix(x)
disp(' ')
disp('Unknown: ')
disp(u)
disp('                  Precision/Recall Table')
display_precision_recall(y)
disp(' ')
avgf1 = sum(y(:,7))/6;
disp('Average F1:')
disp(avgf1)
end

