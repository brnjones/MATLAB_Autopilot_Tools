%Loads a MAVLINK tlog in CSV format.
%Example:  tlog=load_csv_tlog('Z:\uav\Logs\2013-03-30 15-24-18.csv')
% Returns a structure containing all messages.

function [tlog]=load_csv_tlog(filename)
    fid=fopen(filename);
    str=textscan(fid,'%s','Delimiter','\n');
    N=length(str{1});
   
    %find structure names for each sample
    [p_name,start]=regexp(str{1},'(?<=mavlink_)\w+','match','end');
    stop=regexp(str{1},',,Len');

    inc=1;
    for k=1:N
        tmp=str{1}{k}(start{k}+2:stop{k}-1);
        %check validity, currently skips GCS text messages.
        if(~isempty(tmp) && length(strfind(tmp,'severity')) == 0 && ~isempty(p_name{k}))
            test2{inc}=tmp;
            structname{inc}=p_name{k};
            inc=inc+1;
        end
    end

    %separate field and values
    test3=regexp(test2,',','split');
    N=length(test3);
    for k=1:N
        thisstruct=['tlog.',structname{k}{1}];
        packetlen=length(test3{k});
        for m=1:2:packetlen
            field=(test3{k}{m});
            value=test3{k}{m+1};

            if(exist(thisstruct, 'var'))
                eval(['x=isfield(',thisstruct,',''',field,''');'])
                if(x)
                    eval(['z=length(',thisstruct,'.(field));']);
                end
            else
                z=1;
            end

            tmp=regexp(value,'[a-d|f-z]','start','ignorecase');

            if(isempty(tmp))
                var=[thisstruct,'.',field,'(',num2str(z+1),')'];
                eval([var,'=',value,';']);
            else
                var=[thisstruct,'.',field,'{',num2str(z+1),'}'];
                eval([var,'=''',value,''';']);
            end
        end

        if( mod(k,1000)==0 )
            h=waitbar(k/N);
        end
    end
    close(h)

    %save('test.mat','*_t')
end