
dir = dir('ltstdb/1.0.0/*.mat');

for file = dir'
    recordName = regexprep(file.name, 'm.mat', '')
    frame(recordName);
end