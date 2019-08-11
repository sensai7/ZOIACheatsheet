clear;
close all;
clc;
M = tdfread('zoiaCSV.csv');
C = struct2cell(M);

[X Y] = size(C);

result = '<head>\n<link rel="stylesheet" type="text/css" href="theme.css">\n<link href="https://fonts.googleapis.com/css?family=Raleway&display=swap" rel="stylesheet">\n</head>\n<body>\n	<div class="header">\n<h1>Empress Effects ZOIA Cheatsheet</h1>\n<p>Up to date version 1.05. By <a href="https://www.reddit.com/user/gonya707">u/gonya707.</a> Based on Empress Effects <a href="https://empresseffects.com/ZOIA-module-index"> Module index</a>. <a href="https://github.com/sensai7/ZOIACheatsheet">Code on Github</a></p>\n</div>\n';
group = '';

for i =1:X
    module = C(i);
    moduleName = strjoin(cellstr(module{1}(1,:)));
    ModuleDesc = strjoin(cellstr(module{1}(2,:)));
    nBlocks = str2double (module{1}(3,:));
    class = strjoin(cellstr(module{1}(4,:)));
    noSpaces = erase(moduleName,' ');
    
    if ~strcmp(group, class)
        if ~strcmp(group, '')
            result= strcat(result,'</div>\n');
        end
        capClass = class;
        capClass(1) = capClass(1)-32;
        result = strcat(result, '\n<div class="moduleGroup',{' '}, capClass, 'Modules">\n<div class="moduleGroupName">\n<h2>',class, ' Modules</h2>\n</div>\n<div class="LegendWrapper">\n<div class="legend ',{' '}, class, 'Fixed">Required block</div>\n<div class="legend ',{' '}, class, 'Optional">Optional block</div>\n<div class="legend extra">Extra settings</div>\n</div>\n<br/>\n<!--////////////////////////////////////////////////////////////////////////////////////////-->\n');
        group = class;
    end
    %popups
    for j = 1:nBlocks
        blockName = strjoin(cellstr(module{1}((j+4),:)));
        switch (blockName(1))
            case '*'
                blockName = blockName(2:end);
            case '@'
                blockName = blockName(2:end);
        end
        blockDesc = strjoin(cellstr(module{1}((nBlocks+j+4),:)));
        result= strcat(result,'<div id="popup',noSpaces,string(j),'" class="overlay">\n<div class="popup">\n<h2>',moduleName,':',{' '},blockName,'</h2>\n<a class="close" href="#main">&times;</a>\n<div class="content">',blockDesc,'</div>\n</div>\n</div>\n');                                                                                                                                         
    end
    result= strcat(result,'<div id="popup',noSpaces,'" class="overlay">\n<div class="popup">\n<h2>',moduleName,'</h2>\n<a class="close" href="#main">&times;</a>\n<div class="content">',ModuleDesc,'</div>\n</div>\n</div>\n');
    
    %main module
    result= strcat(result,'<div class="',class,'Module">\n<div class="moduleName">\n<h4><a class="nodec" href="#popup', noSpaces,'">',moduleName,'</a></h4>\n</div>\n<div class="blockGroup">\n');
    for j = 1:nBlocks
        blockName = strjoin(cellstr(module{1}((j+4),:)));
        switch (blockName(1))
            case '*'
                type = strcat(class,'Optional');
                blockName = blockName(2:end);
            case '@'
                type = strcat('extra');
                blockName = blockName(2:end);
            otherwise
                type = strcat(class,'Fixed');
        end
        result= strcat(result, '<a class="nodec',{' '},type,' block" href="#popup',noSpaces,string(j),'">',blockName,'</a>\n');
    end
    result= strcat(result,'</div>\n</div>\n<!--////////////////////////////////////////////////////////////////////////////////////////-->\n');
    
end
result= strcat(result,'\n</body>');

fid = fopen('index.html','wt');
fprintf(fid, result);
fclose(fid);