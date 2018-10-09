ods pdf;

*Import data into Work folder;
PROC IMPORT OUT= WORK.PersisForecasting 
            DATAFILE= "C:\Users\sanja\Google Drive\2ndSem\BIA672_Marketi
ngAnalytics_KashaDehnad\RAW-Data\weekly sales.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;




Title "Plot of the Weekly Sale";
proc sgplot data=PersisForecasting;
	series x=number y=total / markers;
run;


*Exponential Forecast with lead of 4 periods;
proc forecast data=PersisForecasting
		method=expo lead=4 trend=1
		out=out_expo_persis outfull outresid outest=est_expo_persis;
	id number;
	var total;
run;

Title "Exponential-Plot of the Error Between Forecast and Actual";
proc sgplot data=out_expo_persis;
	where _type_="RESIDUAL";
	needle x=number y=total / markers markerattrs=(symbol=circlefilled);
run;


Title "Exponential-Plot Between Forecast and Actual";
proc sgplot data=out_expo_persis;
   series x=number y=total / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL';
   
run;

*Double Exponential Forecast with lead of 4 periods;
proc forecast data=PersisForecasting
		method=expo lead=4 trend=2
		out=out_doubleexpo_persis outfull outresid outest=est_expo_persis;
	id number;
	var total;
run;

Title "Double Exponential-Plot of the Error Between Forecast and Actual";
proc sgplot data=out_doubleexpo_persis;
	where _type_="RESIDUAL";
	needle x=number y=total / markers markerattrs=(symbol=circlefilled);
run;


Title "Double Exponential-Plot Between Forecast and Actual";
proc sgplot data=out_doubleexpo_persis;
   series x=number y=total / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL' ;
   
run;


*Seasonal Forecast "Season=4" with lead of 4 periods;
proc forecast data=PersisForecasting 
              method=winters seasons=4  lead=4
              out=out_winters_persis outfull outresid outest=est_persis;
   id number;
   var total;
   
run;
*;

Title "Seasonal 4 -Plot of Error Between Forecast and Actual";
proc sgplot data=out_winters_persis;
	where _type_="RESIDUAL";
	needle x=number y=total / markers markerattrs=(symbol=circlefilled);
run;


Title "Seasonal 4-Plot Between Forecast and Actual";
proc sgplot data=out_winters_persis;
   series x=number y=total / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL';
   
run;


*Seasonal Forecast "Season=5" with lead of 4 periods;
proc forecast data=PersisForecasting 
              method=winters seasons=5  lead=4
              out=out_winters5_persis outfull outresid outest=est_persis5;
   id number;
   var total;
   
run;
*;

Title "Seasonal 5 -Plot of Error Between Forecast and Actual";
proc sgplot data=out_winters5_persis;
	where _type_="RESIDUAL";
	needle x=number y=total / markers markerattrs=(symbol=circlefilled);
run;


Title "Seasonal 5-Plot Between Forecast and Actual";
proc sgplot data=out_winters5_persis;
   series x=number y=total / group=_type_ lineattrs=(pattern=1);
   where _type_ ^= 'RESIDUAL';
   
run;




ods pdf close;
