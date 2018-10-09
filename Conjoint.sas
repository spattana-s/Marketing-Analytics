ods pdf;

PROC IMPORT OUT= WORK.HW3_Conjoint 
            DATAFILE= "C:\Users\jiang\Desktop\BIA672 Final\conjoint.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

title "Preference for Laptop With Factors of Brand, Price, Screen Size, and Memory";
title2 "Metric Conjoint Analysis";
proc transreg data=HW3_Conjoint utilities ;
model identity(rating)=class(Side	Entree	Special	Main/ zero=sum);*Utilities add up to zero;
run; 

ods pdf close;
