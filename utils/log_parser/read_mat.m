%% open *.mat folder
folder = uigetdir("F:");

last_folder = pwd;
cd(folder);

file_names = dir("*.mat");
len = length(file_names);
fname = cell(1, len);
for i = 1:len
    fname{i} = file_names(i).name;
    load(fname{i});
end

cd(last_folder);

run('load_parameter.m');