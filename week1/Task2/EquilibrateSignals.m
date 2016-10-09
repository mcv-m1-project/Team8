function [ImgDatasetX, ImgDatasetY]= EquilibrateSignals(ImgDatasetX, ImgDatasetY, byRealClassAfterTheSplitXorY, byClass, Idx, way)

charsLst=['A';'B';'C';'D';'E';'F'];

if way ==1
    TooBigDataset = ImgDatasetX;
    TooSmallDataset = ImgDatasetY;
else
    TooBigDataset = ImgDatasetY;
    TooSmallDataset = ImgDatasetX;
end

breakKey = 0;


while byRealClassAfterTheSplitXorY(Idx)>byClass(Idx) & breakKey==0
    keysBig=keys(TooBigDataset);
    keysSmall=keys(TooSmallDataset);
    DoBreak=1;
    for i=1:length(keysBig)
        CrImg=TooBigDataset(keysBig{i});
        rClass=CrImg.PhotoRealClass;
        if CrImg.PhotoAmountOfSignals > 1
            if rClass(1)==charsLst(Idx)
                otherLetter=rClass(2);
                for j=1:length(keysSmall)
                    CrOtherImg=TooSmallDataset(keysSmall{j});
                    if CrOtherImg.PhotoAmountOfSignals == 1 & CrOtherImg.PhotoRealClass==otherLetter
                        TooSmallDataset(keysBig{i}) = TooBigDataset(keysBig{i});
                        TooBigDataset(keysSmall{j}) = TooSmallDataset(keysSmall{j});
                        remove(TooBigDataset,keysBig{i});
                        remove(TooSmallDataset,keysSmall{j});
                        byRealClassAfterTheSplitXorY(Idx)=byRealClassAfterTheSplitXorY(Idx)-1;
                        j= length(keysSmall);
                        DoBreak=0;
                    end
                end
            elseif rClass(2)==charsLst(Idx)
                otherLetter=rClass(1);
                for j=1:length(keysSmall)
                    CrOtherImg=TooSmallDataset(keysSmall{j});
                    if CrOtherImg.PhotoAmountOfSignals == 1 & CrOtherImg.PhotoRealClass==otherLetter
                        TooSmallDataset(keysBig{i}) = TooBigDataset(keysBig{i});
                        TooBigDataset(keysSmall{j}) = TooSmallDataset(keysSmall{j});
                        remove(TooBigDataset,keysBig{i});
                        remove(TooSmallDataset,keysSmall{j});
                        byRealClassAfterTheSplitXorY(Idx)=byRealClassAfterTheSplitXorY(Idx)-1;
                        j= length(keysSmall);
                        DoBreak=0;
                    end
                end
            end
        end
    end
    breakKey= DoBreak;
end

if way ==1
    ImgDatasetX = TooBigDataset;
    ImgDatasetY = TooSmallDataset;
else
    ImgDatasetY = TooBigDataset;
    ImgDatasetX = TooSmallDataset;
end

end

            