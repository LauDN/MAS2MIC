/**
* Name: WaterStorageCastel
* Based on the internal empty template. 
* Author: ldunn
* Tags: 
*/


model WaterStorageCastel

species WatterStorage
{

	init 
	{
	
//	csv_file Py1_test0_csv_file <- csv_file("../includes/Py1_test.csv");
//	float RU1 <- 36.0;
//	float RU2 <- 58.0;
//	
//	matrix<float> mat <- matrix<float>(Py1_test0_csv_file);
//	list<float> rr<- list<float>([]);
//	list<float> etm<- list<float>([]);
//	loop ll over:rows_list(mat)
//	{
//		add ll[1] to:rr;
//		add ll[2] to:etm;
//	}
//	
//	list<map<string,float>> res <- BH2R(rr,etm,RU1,RU2,RU1/2,RU2/2);
//	write "taille" + length(res);
//	write "taille" + length(res);
//	
//	matrix<float> mat_res<- matrix<float>({11,length(res)} matrix_with(-1));//matrix({length(res),11}); //matrix<float>()	
//	int j <- 0;
//	
//	save ["RR","ETM","R1","R2","ETR1","ETR2","DR1","DR2","RR1","RR2","Ec"] to: "../includes/test_algo.csv" type:"csv" rewrite: true;
//	loop while:(j<length(res))
//	{
//		map<string,float> rl <- res[j];
//		
//	//	put rl["RR"] in: mat_res at: {0,j};			
////			
//			mat_res[{0,j}] <- rl["RR"];	
//			mat_res[{1,j}] <- rl["ETM"];	
//			mat_res[{2,j}] <- rl["R1"];	
//			mat_res[{3,j}] <- rl["R2"];	
//			mat_res[{4,j}] <- rl["ETR1"];	
//			mat_res[{5,j}] <- rl["ETR2"];	
//			mat_res[{6,j}] <- rl["DR1"];	
//			mat_res[{7,j}] <- rl["DR2"];	
//			mat_res[{8,j}] <- rl["RR1"];	
//			mat_res[{9,j}] <- rl["RR2"];
//			mat_res[{10,j}] <- rl["Ec"];	
//			save [rl["RR"],rl["ETM"],rl["R1"],rl["R2"],rl["ETR1"],rl["ETR2"],rl["DR1"],rl["DR2"],rl["RR1"],rl["RR2"],rl["Ec"]] to: "../includes/test_algo.csv" type:"csv" rewrite: false;
//			
//			j <- j+1;
//	}
//	write mat_res;
	
	//save mat_res to: "../includes/test_algo.csv" type:"csv" rewrite: true;
		
//		create cells_micro_organisms from: micro_orga_cells with: [biomass::float(get("Biomass")), biomass_RMQS::float(get("Biomass_pr"))];
	}
	
	action assign_value(map<string,float> xx,string mname,float value)
	{
		remove key: mname from: xx;
		add value at:mname to:xx;
	}
	
	
	
	
	list<map<string,float>> BH2R(list<float> RR, list<float> ETM, float RU1, float RU2,float PR1,float PR2)
	{
		list<map<string,float>> x <- list([]);
		int i <- 0;
		loop while: i<length(RR)
		{
			map<string,float> tmp <- ["RR"::RR[i],"ETM"::ETM[i],"R1"::-1,"R2"::-1,"ETR1"::-1,"ETR2"::-1,"DR1"::-1,"DR2"::-1,"RR1"::-1,"RR2"::-1,"Ec"::0];
		//	x <- x + list([tmp]);
			add tmp to:x;
			i <- i + 1;
		}
		
		i <- 0;
		float R1 <- 0.0;
		float R2 <- 0.0;
		
		loop while: i<length(x)
		{

		  if(i=0){ //## T0 initialise l'état du réservoir à la RU
	        R1 <- PR1; 
	        R2 <- PR2;      
			if(R1 >= (x[i])["ETM"]){
				//write x[i];
				//write  " " + (x[i])["ETM"];
				do assign_value(x[i],"ETR1",(x[i])["ETM"]);
				do assign_value(x[i],"ETR2",0.0);
			}
			else {
       
	 	      if(R1=0){          
		          if((R2/RU2 * (x[i])["ETM"]) > R2){
					do assign_value(x[i],"ETR1",0.0);           
			        do assign_value(x[i],"ETR2",R2);           
           
		          }
		          else
		          {
		          	do assign_value(x[i],"ETR1",0.0);           
			        do assign_value(x[i],"ETR2",R2/RU2 * (x[i])["ETM"]);               
		          }
	        	}
	        	else{
				
					do assign_value(x[i],"ETR1",R1);           
			     	do assign_value(x[i],"ETR2",R2/RU2 * (x[i])["ETM"] - R1);           
      
		        }      
  	    }

//      ## Détermination de l'état intermédiare des réservoirs
		do assign_value(x[i],"R1",R1 - (x[i])["ETR1"]);                 
		do assign_value(x[i],"R2",R2 - (x[i])["ETR2"]);                 

//      ######################################################
//      
//      ## Réalimentation des réservoirs
//      
//      ######################################################
//      
//      ## Evaluation du déficit des réservoirs
		do assign_value(x[i],"DR1",RU1 - (x[i])["R1"]);                 
		do assign_value(x[i],"DR2",RU2 - (x[i])["R2"]);                 

//      
//      ## Evaluation de la réalimentation
//      
       if((x[i])["DR1"] > (x[i])["RR"]){
//        
		 do assign_value(x[i],"RR1",(x[i])["RR"]);     
		 do assign_value(x[i],"RR2",0.0);     
      }
      else{
       if(((x[i])["RR"]-(x[i])["DR1"]) >= (x[i])["DR2"]){      
       		do assign_value(x[i],"Ec",(x[i])["RR"]-(x[i])["DR1"]-(x[i])["DR2"]);    
       		do assign_value(x[i],"RR1",(x[i])["DR1"]);    
      		do assign_value(x[i],"RR2",(x[i])["DR2"]);    
        }else{
      		do assign_value(x[i],"RR1",(x[i])["DR1"]);    
      		do assign_value(x[i],"RR2",(x[i])["RR"]-(x[i])["DR1"]);              
        }
      }
      do assign_value(x[i],"R1",(x[i])["R1"]+(x[i])["RR1"]);    
      do assign_value(x[i],"R2",(x[i])["R2"]+(x[i])["RR2"]);     
   } else{
//      
     R1 <- (x[i-1])["R1"]; 
     R2 <- (x[i-1])["R2"];
     if(R1 >= (x[i])["ETM"]){
     	do assign_value(x[i],"ETR1",(x[i])["ETM"]);
		do assign_value(x[i],"ETR2",0.0);      
      } else{
	      if(R1=0)
	      {
	         if((R2/RU2 * (x[i])["ETM"]) > R2){
	         	do assign_value(x[i],"ETR1",0.0);
	         	do assign_value(x[i],"ETR2",R2);
 	          }
 	          else
 	          {
	            do assign_value(x[i],"ETR1",0.0);
	            do assign_value(x[i],"ETR2",R2/RU2 * (x[i])["ETM"]);
	         }        
          }
		  else
		  {
		  	do assign_value(x[i],"ETR1",R1);
	        do assign_value(x[i],"ETR2",R2/RU2 * ((x[i])["ETM"] - R1));
        }
      }
//      
//      ## Détermination de l'état intermédiare des réservoirs
//      
		do assign_value(x[i],"R1",R1 - (x[i])["ETR1"]);
		do assign_value(x[i],"R2",R2 - (x[i])["ETR2"]);
//      
//      ######################################################
//      
//      ## Réalimentation des réservoirs
//      
//      ######################################################
//      
//      ## Evaluation du déficit des réservoirs
//      
		do assign_value(x[i],"DR1",RU1 - (x[i])["R1"]);
		do assign_value(x[i],"DR2",RU2 - (x[i])["R2"]);
//      
//      
//      ## Evaluation de la réalimentation
//      
//      
//      
        if((x[i])["DR1"] > (x[i])["RR"])
        {
			do assign_value(x[i],"RR1", (x[i])["RR"]);
			do assign_value(x[i],"RR2", 0.0);
        }
		else
		{
         if(((x[i])["RR"]-x[i]["DR1"]) >= x[i]["DR2"])
         {
           do assign_value(x[i],"Ec", (x[i])["RR"]-(x[i])["DR1"]-(x[i])["DR2"]);
		   do assign_value(x[i],"RR1", (x[i])["DR1"]);
		   do assign_value(x[i],"RR2", (x[i])["DR2"]);
	      
         }
         else
         {
           do assign_value(x[i],"RR1", (x[i])["DR1"]);
		   do assign_value(x[i],"RR2", (x[i])["RR"]-(x[i])["DR1"]);
		    
         }
       }

	 do assign_value(x[i],"R1", (x[i])["R1"]+(x[i])["RR1"]);
	 do assign_value(x[i],"R2", (x[i])["R2"]+(x[i])["RR2"]);
		  
    }
    
	i <- i + 1;
  }
  



return x;
}
//	species cells_micro_organisms 
//	{
//		float biomass;
//		float biomass_RMQS;
//	}
}




