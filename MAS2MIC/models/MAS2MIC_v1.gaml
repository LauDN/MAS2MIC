/**
* Name: MAS2MICv1
* Based on the internal empty template. 
* Author: ldunn
* Tags: 
*/


model MAS2MICv1
import "WaterStorageCastel.gaml" 
global 
{
	int number_sim;
	bool execute_sub_reflex <- false;
	int time_impact;
	float a_micro_growth;
	float k_micro_carrying;

	
	date starting_date <- date("2010-09-25", "yyyy-MM-dd"); //le 1 septembre 2021
	
	
	reflex when: current_date.date = date("2010-09-25", "yyyy-MM-dd")
	{
		ask cells_micro_organisms
		{
			recovery <- 1.0;
		}
	}

	
//	reflex when: current_date.date = date("2016-09-25", "yyyy-MM-dd") or current_date.date = date("2019-09-25", "yyyy-MM-dd")
//	{
//	save cells_micro_organisms to:"../Calib/SIM" + number_sim + "_" + current_date.year +".shp" type:"shp" attributes: ["Biomass"::my_biomass, "ID_cells"::id_cell ]; //crs: "EPSG:2154";
//	}
	
	reflex stop_sim when: current_date.date = date("2019-09-26", "yyyy-MM-dd")
	{
		do die;
	}

	/////// Histogram impact practices\\\\\\

	geometry histo_crop_GR1 <- polygon ([{0.0,0.0,0.0},{0.0,46,0.0},{25,46 ,0.0},{25,224 ,0.0},{50,224,0.0},{50,149,0.0},{75,149 ,0.0},{75,41 ,0.0},{100,41 ,0.0},
		{100,6,0.0},{125,6 ,0.0},{125,3 ,0.0},{150,3,0.0},{150,1,0.0},{175,1,0.0},{175,0,0.0},{200,0,0.0},{200,1,0.0},{225,1,0.0},{225,0,0.0},{250,0,0.0},
		{250,0,0.0},{275,0,0.0},{275,0,0.0},{300,0,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,0,0.0},{375,0,0.0},{375,0,0.0},{0.0,0.0,0.0}]); 
	geometry histo_crop_GR2 <- polygon ([{0.0,0.0,0.0},{0.0,2,0.0},{25,2 ,0.0},{25,3 ,0.0},{50,3,0.0},{50,8,0.0},{75,8 ,0.0},{75,14 ,0.0},{100,14 ,0.0},
		{100,20,0.0},{125,20 ,0.0},{125,14 ,0.0},{150,14,0.0},{150,8,0.0},{175,8,0.0},{175,7,0.0},{200,7,0.0},{200,4,0.0},{225,4,0.0},{225,4,0.0},{250,4,0.0},
		{250,1,0.0},{275,1,0.0},{275,2,0.0},{300,2,0.0},{300,1,0.0},{325,1,0.0},{325,0,0.0},{350,0,0.0},{350,2,0.0},{375,2,0.0},{375,0,0.0},{0.0,0.0,0.0}]); 
	
	geometry histo_travail_GR1 <- polygon ([{0.0,0.0,0.0},{0.0,43,0.0},{25,43 ,0.0},{25,213 ,0.0},{50,213,0.0},{50,137,0.0},{75,137 ,0.0},{75,37 ,0.0},{100,37 ,0.0},
		{100,5,0.0},{125,5 ,0.0},{125,1 ,0.0},{150,1,0.0},{150,1,0.0},{175,1,0.0},{175,0,0.0},{200,0,0.0},{200,1,0.0},{225,1,0.0},{225,0,0.0},{250,0,0.0},
		{250,0,0.0},{275,0,0.0},{275,0,0.0},{300,0,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,0,0.0},{375,0,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	geometry histo_travail_GR2 <-  polygon ([{0.0,0.0,0.0},{0.0,5,0.0},{25,5 ,0.0},{25,14 ,0.0},{50,14,0.0},{50,20,0.0},{75,20 ,0.0},{75,18 ,0.0},{100,18 ,0.0},
		{100,21,0.0},{125,21 ,0.0},{125,16 ,0.0},{150,16,0.0},{150,8,0.0},{175,8,0.0},{175,7,0.0},{200,7,0.0},{200,4,0.0},{225,4,0.0},{225,4,0.0},{250,4,0.0},
		{250,1,0.0},{275,1,0.0},{275,2,0.0},{300,2,0.0},{300,1,0.0},{325,1,0.0},{325,0,0.0},{350,0,0.0},{350,2,0.0},{375,2,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
		
	geometry histo_pesti_GR1 <- polygon ([{0.0,0.0,0.0},{0.0,40,0.0},{25,40 ,0.0},{25,210 ,0.0},{50,210,0.0},{50,140,0.0},{75,140 ,0.0},{75,38 ,0.0},{100,38 ,0.0},
		{100,6,0.0},{125,6 ,0.0},{125,1 ,0.0},{150,1,0.0},{150,1,0.0},{175,1,0.0},{175,0,0.0},{200,0,0.0},{200,1,0.0},{225,1,0.0},{225,0,0.0},{250,0,0.0},
		{250,0,0.0},{275,0,0.0},{275,0,0.0},{300,0,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,0,0.0},{375,0,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	geometry histo_pesti_GR2 <- polygon ([{0.0,0.0,0.0},{0.0,8,0.0},{25,8 ,0.0},{25,17 ,0.0},{50,17,0.0},{50,17,0.0},{75,17 ,0.0},{75,17 ,0.0},{100,17 ,0.0},
		{100,20,0.0},{125,20 ,0.0},{125,16 ,0.0},{150,16,0.0},{150,8,0.0},{175,8,0.0},{175,7,0.0},{200,7,0.0},{200,4,0.0},{225,4,0.0},{225,4,0.0},{250,4,0.0},
		{250,1,0.0},{275,1,0.0},{275,2,0.0},{300,2,0.0},{300,1,0.0},{325,1,0.0},{325,0,0.0},{350,0,0.0},{350,2,0.0},{375,2,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
		
	geometry histo_ferti_GR1 <- polygon ([{0.0,0.0,0.0},{0.0,44,0.0},{25,44 ,0.0},{25,212 ,0.0},{50,212,0.0},{50,142,0.0},{75,142 ,0.0},{75,38 ,0.0},{100,38 ,0.0},
		{100,6,0.0},{125,6 ,0.0},{125,1 ,0.0},{150,1,0.0},{150,1,0.0},{175,1,0.0},{175,0,0.0},{200,0,0.0},{200,1,0.0},{225,1,0.0},{225,0,0.0},{250,0,0.0},
		{250,0,0.0},{275,0,0.0},{275,0,0.0},{275,0,0.0},{300,0,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,0,0.0},{375,0,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	geometry histo_ferti_GR2 <-polygon ([{0.0,0.0,0.0},{0.0,4,0.0},{25,4 ,0.0},{25,15 ,0.0},{50,15,0.0},{50,15,0.0},{75,15 ,0.0},{75,17 ,0.0},{100,17 ,0.0},
		{100,20,0.0},{125,20 ,0.0},{125,16 ,0.0},{150,16 ,0.0},{150,8,0.0},{175,8,0.0},{175,7,0.0},{200,7,0.0},{200,4,0.0},{225,4,0.0},{225,4,0.0},{250,4,0.0},
		{250,1,0.0},{275,1,0.0},{275,2,0.0},{275,2,0.0},{300,2,0.0},{300,1,0.0},{325,1,0.0},{325,0,0.0},{350,0,0.0},{350,2,0.0},{375,2,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
		
	geometry histo_water_GR1 <- polygon ([{0.0,0.0,0.0},{0.0,39,0.0},{25,39 ,0.0},{25,146 ,0.0},{50,146,0.0},{50,107,0.0},{75,107,0.0},{75,35,0.0},{100,35,0.0},{100,4,0.0},
		{125,4,0.0},{125,1,0.0},{150,1,0.0},{150,0,0.0},{175,0,0.0},{175,0,0.0},{200,0,0.0},{200,1,0.0},{225,1,0.0},{225,0,0.0},{250,0,0.0},{250,0,0.0},{275,0,0.0},
		{275,0,0.0},{300,0,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,0,0.0},{375,0,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	geometry histo_water_GR2 <- polygon ([{0.0,0.0,0.0},{0.0,1,0.0},{25,1 ,0.0},{25,38 ,0.0},{50,38,0.0},{50,20,0.0},{75,20,0.0},{75,2,0.0},{100,2,0.0},{100,1,0.0},
		{125,1,0.0},{125,0,0.0},{150,0,0.0},{150,0,0.0},{175,0,0.0},{175,0,0.0},{200,0,0.0},{200,0,0.0},{225,0,0.0},{225,0,0.0},{250,0,0.0},{250,0,0.0},{275,0,0.0},
		{275,0,0.0},{300,0,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,0,0.0},{375,0,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	geometry histo_water_GR3 <- polygon ([{0.0,0.0,0.0},{0.0,1,0.0},{25,1 ,0.0},{25,8 ,0.0},{50,8,0.0},{50,2,0.0},{75,2,0.0},{75,9,0.0},{100,9,0.0},{100,8,0.0},
		{125,8,0.0},{125,8,0.0},{150,8,0.0},{150,2,0.0},{175,2,0.0},{175,2,0.0},{200,2,0.0},{200,0,0.0},{225,0,0.0},{225,0,0.0},{250,0,0.0},{250,0,0.0},{275,0,0.0},
		{275,1,0.0},{300,1,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,0,0.0},{375,0,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	geometry histo_water_GR4 <- polygon ([{0.0,0.0,0.0},{0.0,4,0.0},{25,4 ,0.0},{25,29,0.0},{50,29,0.0},{50,14,0.0},{75,14,0.0},{75,1,0.0},{100,1,0.0},{100,1,0.0},
		{125,1,0.0},{125,1,0.0},{150,1,0.0},{150,1,0.0},{175,1,0.0},{175,0,0.0},{200,0,0.0},{200,0,0.0},{225,0,0.0},{225,0,0.0},{250,0,0.0},{250,0,0.0},{275,0,0.0},
		{275,1,0.0},{300,1,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,0,0.0},{375,0,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	geometry histo_water_GR5 <- polygon ([{0.0,0.0,0.0},{0.0,0,0.0},{25,0 ,0.0},{25,3,0.0},{50,3,0.0},{50,9,0.0},{75,9,0.0},{75,3,0.0},{100,3,0.0},{100,9,0.0},
		{125,9,0.0},{125,3,0.0},{150,3,0.0},{150,2,0.0},{175,2,0.0},{175,1,0.0},{200,1,0.0},{200,2,0.0},{225,2,0.0},{225,2,0.0},{250,2,0.0},{250,0,0.0},{275,0,0.0},
		{275,0,0.0},{300,0,0.0},{300,1,0.0},{325,1,0.0},{325,0,0.0},{350,0,0.0},{350,1,0.0},{375,1,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	geometry histo_water_GR6 <- polygon ([{0.0,0.0,0.0},{0.0,3,0.0},{25,3,0.0},{25,3,0.0},{50,3,0.0},{50,5,0.0},{75,5,0.0},{75,5,0.0},{100,5,0.0},{100,3,0.0},
		{125,3,0.0},{125,4,0.0},{150,4,0.0},{150,4,0.0},{175,4,0.0},{175,4,0.0},{200,4,0.0},{200,2,0.0},{225,2,0.0},{225,2,0.0},{250,2,0.0},{250,1,0.0},{275,1,0.0},
		{275,1,0.0},{300,1,0.0},{300,0,0.0},{325,0,0.0},{325,0,0.0},{350,0,0.0},{350,1,0.0},{375,1,0.0},{375,0,0.0},{0.0,0.0,0.0}]);
	
	list<rgb> grass_colors <- list<rgb>([rgb(247,252,245),rgb(229,245,224),rgb(199,233,192),rgb(161,217,155),rgb(116,196,118),rgb(65,171,93),rgb(35,139,69),rgb(0,109,44),rgb(0,68,27)]);
	
	map<string,image_file> practice_icon <- map<string,image_file>(
			["Travail-sol"::image_file("../includes/mini_travail_sol.png"),
			"Fertilisation"::image_file("../includes/mini_fertilisant.png"),
			"Traitement"::image_file("../includes/mini_pesticide.png"),
			"Culture"::image_file("../includes/mini_semis.png"),
			"Recolte"::image_file("../includes/mini_recolte.png")
		]);
	map<string,unknown> data_graph;
	string micro_orga_cells_path 		<- "../includes/small_example/microcells_exemple.shp";
	string fields_file_path 			<- "../includes/small_example/landscape.shp";
	string Climate_file_path 			<- "../includes/small_example/landscape_climate.csv";
	string farms_file_path 			<- "../includes/small_example/nom_exploit_agri_example.csv";
	string actions_file_path			<- "../includes/small_example/actions_farmers_example.csv";
	string KC_file_path				<- "../includes/small_example/test_Kc_4.csv";
	
	file micro_orga_cells 		<- shape_file(micro_orga_cells_path);
	file fields_file 			<- shape_file(fields_file_path);
	file Climate_file 			<- csv_file(Climate_file_path,";",string,true);
	file farms_file 			<- csv_file(farms_file_path,true);
	file actions_file			<- csv_file(actions_file_path,true);
	file KC_file 				<- csv_file(KC_file_path,true);
	
	geometry shape <- envelope(micro_orga_cells);
	
//	float K_invasive_grass <- 0.1;
//	float grow_rate_invasive_grass <- 0.20;
//	float diffuse_rate_l1 <- 0.2;
//	float diffuse_rate_l2 <- 0.05;
//	
	
	map<string,map<int,plant>> all_plants;
	float step <- 1 #day;
	Climate climate;
	
	map<string, int> LEVEL_TRAVAIL <- ['Labour'::3,'Dechaumage'::2,'Decompactage'::2,'Destruction_Meca'::2,'Autre'::1,'Binage'::1,'Broyage'::1, 'Desh_meca'::1,'Entretien_culture'::1,'Faux_semis'::1,'Prep_Semis'::1,'Reprise_de_sol'::1,'Roulage'::1];
		
	WatterStorage watterStorage;
			
	init
		{
			create WatterStorage ;
			watterStorage <- first(WatterStorage);
			create Farmers from:farms_file with:[name_exploit::string(get("EXPLOIT"))];
			create cells_micro_organisms from: micro_orga_cells with: [id_cell::string(read("nameAgent")),initial_biomass::float(get("Biomass")), biomass_RMQS::float(get("Biomass_pr")),RUM::int(get("Water_stor")),
				Clay::float(get("Clay")), Sand::float(get("Sand")), coeff_texture::float(get("coeff_text")), my_plot::string(read("N_PARCELLE")), my_farmer::string(read("EXPLOIT"))];
			create Field from:fields_file with:[name::string(read("N_PARCELLE")), 
				landuse::string(read("TypeZone")),
				farm_name :: string(read("EXPLOIT")),
				previous_crop::string(read("prev_crop")),
				freq_plo :: float(read("freq_plo_1")),
				freq_brassi :: float(read("freq_brass")),
				prof_sol :: string(read("Prof_sol"))]
				{
					owner <- Farmers first_with(each.name_exploit = self.farm_name);
					write farm_name;
					micro_cells <- cells_micro_organisms where(each.my_plot = self.name);
					ask micro_cells 
					{
						self.my_field <- myself;
						self.my_field_name <- myself.name;
					}
				}
			do init_neighbourhood;
			
			matrix data <- matrix(KC_file);
			create plant from:KC_file with: [dec::int(get("decade")), considered_crop::string(get("culture")),kc_dec_crop::float(get("valeur"))];
			create Climate number:1 returns: cc
			{
				create Climate_context from:Climate_file  with:[bidule::read("mdate"),RR::float(read("RR")),ETP_P::float(read("ETPPenman"))] returns: tempList
				{
					my_date<- date(bidule,"yyyy-MM-dd");
					write "date +" +my_date.date +" "+ bidule;
					
				}
			
				loop element over:tempList
				{
					add element at:element.my_date.date to:climate_contexts;
				}
				
			}
			
			climate <- first(cc);
			
			create actions from:actions_file     with:[plot::string(get("N_PARCELLE")), 
													date_practice::date(get("Date_debut")),  //,"yyyy-MM-dd"
//													end_practice::date(get("Date_fin")),
//													duration::int(get("Duree")), 
													type_practice::string(get("Type_intervention")),
													details_practice::string(get("Detail_intervention")),
													crop::string(get("Crop")),
													N::float(get("N")),
													P::float(get("P")),
													K::float(get("K")),
													MG::float(get("MG")),
													S::float(get("S")), 
													herbi::float(get("Herbi")),
													fongi::float(get("Fongi")),
													mollus::float(get("Mollus")),
													insect::float(get("insect"))]
			{

				do upgrade_actions;

			}
				
			ask Farmers
			{
				my_actions <- my_actions sort(each.date_practice);
			}									
		}
	
	action update_graph(string exp) {
 		list<float> l_data <- list<float>(data_graph[exp]);
 		list<list<float>> l_data_err <- list<list<float>>(data_graph[exp+"_err"]);
 		if(l_data=nil) {
 			l_data <- [];
 			l_data_err <- [];
 		}
 		float m <- mean(Farmers where(each.name_exploit =exp) collect (float(each.mean_biomass)));
		list<float> err	<- [cells_micro_organisms where(each.my_farmer =exp) min_of(each.my_biomass),
							cells_micro_organisms where(each.my_farmer =exp) max_of(each.my_biomass)];
		
		
		add m to:l_data;
		add err to:l_data_err;
		put l_data at:exp in:data_graph;
		put l_data_err at:exp+"_err" in:data_graph;
		
	 }
	date get_current_date
	{
		return current_date.date;
	}
//	list<map<string,unknown>> get_information_of_fields(string nom_expl)
//	{
//		write Farmers collect(each.name_exploit);
//		write "nom exploit *"+nom_expl+"*";
//		write "nom exploit *"+(Farmers where(each.name_exploit = nom_expl))+"*";
//		write Field collect (each.owner);
//		return (Field where (each.owner !=nil and each.owner.name_exploit =nom_expl )) collect(each.field_information());
//	}
	rgb choose_color(float value,float max, list<rgb> clr)	
	{
		//write "choose  "+value+" "+max+" list "+ clr;
		if(value = 0)
		{
			return clr[0] ;		
		}
		int size <- length(clr)-1;
		float inc <- max / size;
		int id <- min([length(clr)-1, 1+(value div inc)]);
		return clr[id];
		
	}

	action init_neighbourhood
	{
		ask cells_micro_organisms
		{
			geometry first_n <- 30#m around self.shape;
			
			list<cells_micro_organisms> all_cells <- cells_micro_organisms where(each.my_field.landuse="Culture");
			list<cells_micro_organisms> level1 <- all_cells overlapping(first_n);
			geometry second_n <- 70#m around self.shape;
			list<cells_micro_organisms> level2 <- all_cells overlapping(second_n);
			
			loop l over:level1
			{
				remove all:l from:level2;
			}
			remove all:self from:level1;

			neighbourhood_1<-level1;
			neighbourhood_2<-level2;
		}
		
	}
	
	
	int counter <- 1;
	
	reflex play_agent
	{
		counter <- counter +1;
		if counter mod 16 = 0
		{
//			do diffuse_m;
		}
			
		ask Climate
		{
			do do_step;
						
		}
		ask Field
		{
			do do_step;
		}
		ask Farmers
		{
			do do_step;
		}

		ask cells_micro_organisms
		{
			do do_step;
		}

	}
	
	reflex give_time
	{
			write current_date.date;
	}
	


	map<string,unknown> create_actions(map<string,unknown> data)
	{
		create actions returns:l
		{
			action_id <-data["action_id"];
			plot <- data["parcelle_id"];
			date_practice <- date(data["action_date"]); //date(data["date_practice"]);
			end_practice <- date_practice;
			type_practice <- data["type_practice"];
			details_practice <- data["details_practice"];
			crop <- data["crop"];
			N <- float(data["N"]);
			P <- float(data["P"]);
			K <- float(data["K"]);
			MG <- float(data["MG"]);
			S <- float(data["S"]);
			herbi <- float(data["herbi"]);
			fongi <- float(data["fongi"]);
			mollus <- float(data["mollus"]);
			insect <- float(data["insect"]);
			write data;
			do upgrade_actions;
			
		}
		return first(l).serialize();
	}

	list<map<string,unknown>> retrieve_actions(string farm_id)
	{
		Farmers farm <- Farmers first_with(each.name_exploit = farm_id);
		list<map<string,unknown>> res <- [];
		ask actions where(each.fields.owner = farm)
		{
			map<string,unknown> tmp <- self.serialize();
			add tmp to:res;
		}
		return res;
	}
	
	action del_action_with_id(string id) {
		ask actions where(each.action_id = id)
		{
			ask fields
			{
				remove myself from:my_action_done;
			}
			ask fields.owner
			{
				remove myself from:my_actions;
			}
			do die;
		}
	}
	
	action new_year
	{
		ask(Field)
		{
			do changing_year;
		}	
		ask Farmers
		{
			my_actions <- my_actions sort(each.date_practice);
		}
	}

}
species Field
{
	string name;
	string landuse;
	string farm_name;
	float freq_plo max:1.0 min:0.0;
	float freq_brassi max:1.0 min:0.0;
	string prof_sol;
	Farmers owner;
	string previous_crop;
	float add_or_remove <- 0.0;
	float search_brassi <- 0.0;
	float impact <- 1.0;
	list<actions> my_action_done <- [];
	float my_P <-0.0;
	float my_N_min <-0.0;
	float my_K  <-0.0;
	float my_MG  <- 0.0;
	float my_S  <- 0.0;
	float my_herbi  <- 0.0;
	float my_fongi  <- 0.0;
	float my_pest_tot  <- 0.0;
	int prof_travail_sol;
	float biomass_per_field -> {mean(micro_cells collect (float(each.my_biomass)))};
	float mean_biomass_RMQS -> {mean(micro_cells collect (float(each.biomass_RMQS)))} ;
	float biomass_per_field_last_year;
	int my_water_stress  max:365 min:0.0 -> {max(micro_cells collect (int(each.days_of_water_stress)))};
	int previous_water_stress max:365 min:0.0;
	
	rgb color_tillage;
	rgb color_IFT_Total;
	rgb color_Herbi;
	rgb color_ferti;
	rgb color_crop;
	list<cells_micro_organisms> micro_cells <-[];
	init
	{
		do update_param;
	}
	
	reflex my_step when:execute_sub_reflex
	{
		do do_step;
	}
	
	action do_step
	{
		do update_me;
		if(my_water_stress=previous_water_stress and my_water_stress>0 and current_date.date > date("2011-09-25", "yyyy-MM-dd"))
		{
			do apply_water_stress;		
		}	
		if my_water_stress = 1 and my_water_stress > previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 1 and my_water_stress < previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 44 and my_water_stress > previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 44 and my_water_stress < previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 50 and my_water_stress > previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 50 and my_water_stress < previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 52 and my_water_stress > previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 52 and my_water_stress < previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 59 and my_water_stress > previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 59 and my_water_stress < previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 79 and my_water_stress > previous_water_stress
		{
			do apply_water_stress;
		}
		if my_water_stress = 79 and my_water_stress < previous_water_stress
		{
			do apply_water_stress;
		}
	}
	
	
	action update_me
	{
		do update_param;
	}

	
	action update_param
	{
		list<actions> ferti <- my_action_done where( each.type_practice="Fertilisation" and each.date_practice > current_date.date - 1#year);
		my_P <- sum(ferti collect (float (each.P)));
		my_N_min <- sum(ferti collect (float (each.N)));
		my_K  <- sum(ferti collect (float (each.K)));
		my_MG  <- sum(ferti collect (float (each.MG)));
		my_S  <- sum(ferti collect (float (each.S)));
		my_herbi  <- sum(my_action_done where( each.details_practice="Herbicide") collect (float (each.herbi)));
		my_fongi  <-sum(my_action_done where( each.details_practice="Fongicide") collect (float (each.fongi)));
		my_pest_tot  <-sum(my_action_done where(each.type_practice="Traitement") collect (float (each.fongi)+float(each.herbi) + float(each.mollus + float(each.insect))));
	}
	
	aspect border_line 
	{
		draw line(shape.points) color:#black;
	}
	
	aspect travail_du_sol
	{


			if prof_travail_sol = 3 
			{
				color_tillage <- rgb(102,70,2);
			}
			if prof_travail_sol =  2 
			{
				color_tillage <- rgb(184,127,5) ;
			}	
			if prof_travail_sol =  1
			{
				color_tillage <- rgb(137,190,0) ;
			}
			if prof_travail_sol = 0
			{
				color_tillage <- #green;
			}
		draw shape color:color_tillage border:#black;

		
	}
	
	rgb color_herbi(float val)
	{
		  switch(val)
		  {
		  	match_between [-1000.0,0] {return #white; }
		  	match_between [0.0,0.5] {return rgb( 215, 215, 215); }
		  	match_between [0.5,1.0] {return rgb( 180, 180, 180); }
		  	match_between [1.0,1.5] {return rgb( 145, 145, 145); }
		  	match_between [1.5,2.0] {return rgb( 110, 110, 110); }
		  	match_between [2.0,2.5] {return rgb( 75, 75, 75); }
		  	match_between [2.5,3.0] {return rgb( 40, 40, 40); }
		  	match_between [3.0,100]  {return rgb( 5, 5, 5); }
		  	default   {return rgb( 5, 5, 5); }
		  }
	}
	aspect ift_herbi
	{
		draw shape color:color_herbi(my_herbi) border:#black;
	}
	aspect culture_en_place
	{
		if previous_crop in ['Colza','Colza_hiver','Colza_hiver_industriel','Moutarde_brune','Moutarde_hiver','Moutarde','Moutarde_printemps']
				{
					color_crop <- rgb(253,231,37);
				}
			if previous_crop in ['Ble_tendre_hiver','Orge_hiver'] //CULTURE HIVER
			{
				color_crop <- rgb(29,0,219);
			}
			if previous_crop in ['Pois_prot._printemps','Orge_printemps','Ble_tendre_printemps','Mais_grain'] //culture printemps
			{
				color_crop <- rgb(122,210,81);
			}
			if previous_crop in ['Soja','Tournesol'] // été
			{
				color_crop <- rgb(251,154,153);	
			}
		draw shape color:color_crop border:#black;
	}
	action apply_water_stress  //when: 0 = current_date.date.day_of_year mod 10 //every(10#days)
	{
		if my_water_stress > 0
		{
			previous_water_stress <- my_water_stress;
			if my_water_stress < 44 
			{
				list<float> list_impact_water_stress <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_water_GR1)).x;
					add tmp to: list_impact_water_stress;
				}

				impact <- mean(list_impact_water_stress)/mean_biomass_RMQS;
				write name + "water impact" + impact  ;
			}
			else if my_water_stress >= 44 and my_water_stress < 49.5
			{
				list<float> list_impact_water_stress <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_water_GR3)).x;
					add tmp to: list_impact_water_stress;
				}
				impact <- mean(list_impact_water_stress)/mean_biomass_RMQS;
				write name + "water impact" + impact  ;
			}
			else if my_water_stress >= 49.5 and my_water_stress < 52
			{
				list<float> list_impact_water_stress <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_water_GR2)).x;
					add tmp to: list_impact_water_stress;
				}
				impact <- mean(list_impact_water_stress)/mean_biomass_RMQS;
				write name + "water impact" + impact  ;
			}
			else if my_water_stress >= 52 and my_water_stress < 58.5
			{
				list<float> list_impact_water_stress <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_water_GR6)).x;
					add tmp to: list_impact_water_stress;
				}
				impact <- mean(list_impact_water_stress)/mean_biomass_RMQS;
				write name + "water impact" + impact  ;
			}
			else if my_water_stress >= 58.5 and my_water_stress < 79
			{
				list<float> list_impact_water_stress <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_water_GR4)).x;
					add tmp to: list_impact_water_stress;
				}
				impact <- mean(list_impact_water_stress)/mean_biomass_RMQS;
				write name + "water impact" + impact  ;
			}
			else if my_water_stress >= 79
			{
				list<float> list_impact_water_stress <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_water_GR5)).x;
					add tmp to: list_impact_water_stress;
//					write "I add" + tmp + "to water impact";
				}
				impact <- mean(list_impact_water_stress)/mean_biomass_RMQS;
				write name + "water impact" + impact  ;
			}
			ask micro_cells
			{
				time_after_impact <- 0;
				time_passed <- 1;
				temp_bio <- self.my_biomass;
				self.threshold <- self.temp_bio * myself.impact;
				recovery <- time_impact + 1;
			}
		}
//		save ["Type"::"Days of water stress","Modality"::my_water_stress, "Impact"::impact] to: "../Calib/SIM" + number_sim + "_" + "impacts" +".csv" type:"csv" rewrite: false;
		
	}
	
		action changing_year// when: since(starting_date.date + 1#year) and current_date.date.day_of_year=1 
	{
		write"Changing year ................ !!!!!!!!!!!!!!!";
		add_or_remove <- -0.25;
		search_brassi <- -0.25;
		ask actions where(each.plot = name and each.date_practice.date < current_date.date)
		{
			if self.details_practice in ['Labour']
			{
			myself.add_or_remove <- 0.25;	
			}
		}
			
	if previous_crop in ['Colza','Colza_hiver','Colza_hiver_industriel','Moutarde_brune','Moutarde_hiver','Moutarde','Moutarde_printemps']
		{
			search_brassi <- 0.25;
		}
		freq_plo <- freq_plo + add_or_remove;
		freq_brassi <- freq_brassi + search_brassi;
		prof_travail_sol <-0;
		
	}
	
}
species Farmers
{
	string name_exploit;
	list<Field> my_fields -> {Field where(each.owner = self)};
	list<actions> my_actions <-[];
	bool do_smthg <- false;
	float mean_biomass -> {mean(cells_micro_organisms where(each.my_farmer = self.name_exploit) collect (float(each.my_biomass)))};
	
	reflex my_step when:execute_sub_reflex
	{
		do do_step;
	}
	
	action do_step
	{
		
		if(first(my_actions)!=nil and first(my_actions).date_practice.date = current_date.date )
		{
			do play_activity;
		}
	}
	
	action play_activity 
	{
		do_smthg <- true;
		
		loop while:!empty(my_actions) and first(my_actions).date_practice.date = current_date.date
		{
			actions current_action <-first(my_actions);
			ask current_action
			{
		
				do apply_me;
			}
			remove current_action from: my_actions;
		}
	}
			
}
species actions 
{
 string action_id <-nil;	
 Field fields;
 string plot;
date date_practice;
date end_practice;
string type_practice;
string details_practice;
string crop;
float N;
float P;
float K;
float MG;
float S; 
float herbi;
float fongi;
float mollus;
float insect;
image_file my_icon ->{practice_icon[type_practice]};
bool is_activated <- false;
	
	action upgrade_actions
	{
		fields <- Field first_with(each.name = self.plot);
		if(action_id = nil)
		{
		  action_id <- fields.owner.name_exploit +"_"+length(fields.owner.my_actions);	
		}
		write " "+ fields.owner+ " "+ self.plot;
		
		write "date_practice " + date_practice+" starting_date "+ starting_date;
		
		if date_practice >= starting_date
		{
			ask fields.owner
			{
				write "ajout action " + self.my_actions;
				add myself to:self.my_actions;
				write "apres  ajout action " + self.my_actions;
				
			}
		}
		
		location <- fields.location;
		shape <- fields.shape;
	}
	
	action apply_me 
	{
		ask fields
		{
			add myself to:my_action_done;
			do update_param;
		}
		
		switch(type_practice)
		{
			match "Travail-sol" {do Tillage;}
			match  "Fertilisation" {do Fertilisation;}
			match "Traitement" {do Traitement;}
			match "Culture" {do Culture;}
			match "Recolte"{do Recolte;}
		}
		is_activated <-true;
		if current_date.date > date("2011-09-25", "yyyy-MM-dd")
		{
			ask fields.micro_cells
			{
			recovery <- time_impact + 1;
			time_passed <- 1;
			time_after_impact <- 0;
			}
		}
		
		
//		save ["Type"::type_practice,"Modality"::details_practice,"Impact"::fields.impact] to: "../Calib/SIM" + number_sim + "_" + "impacts" +".csv" type:"csv" rewrite: false;
	}
	
	action Tillage
	{
		if details_practice in ['Labour']
		{
			ask fields
			{
				self.prof_travail_sol <- 3;
			}
		}
		if details_practice in ['Dechaumage','Decompactage','Destruction_Meca'] 
		{
			ask fields
			{
				self.prof_travail_sol <- max([prof_travail_sol,2]);
			}
		}
		else if details_practice in ['Autre','Binage', 'Desh_meca','Entretien_culture','Faux_semis','Prep_Semis','Reprise_de_sol','Roulage']
		{
			ask fields
			{
			self.prof_travail_sol <- max([prof_travail_sol,1]);	
			}
		}
		
		ask fields
			{
				list<float> list_impact_tillage <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_travail_GR1)).x;
					add tmp to: list_impact_tillage;
				}
				self.impact <- mean(list_impact_tillage)/mean_biomass_RMQS ;
				write name + "tillage impact" + impact  ;
								
				ask micro_cells
					{
						temp_bio <- self.my_biomass;
						self.threshold <- self.temp_bio * myself.impact;
						self.my_color <-#red;
					}
			}	
		}
	action Fertilisation
	{
		ask fields
		{
			if self.my_P < 0.125 //GR2
			{
				list<float> list_impact_ferti <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_ferti_GR2)).x;
					add tmp to: list_impact_ferti;
				}
				self.impact <- mean(list_impact_ferti)/mean_biomass_RMQS ;
				write name + "ferti impact" + impact  ;
			}
			else if self.my_P >= 0.125 //GR1
			{
				list<float> list_impact_ferti <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_ferti_GR1)).x;
					add tmp to: list_impact_ferti;
				}
				self.impact <- mean(list_impact_ferti)/mean_biomass_RMQS;
				write name + "ferti impact" + impact  ;
			}
			
				 ask micro_cells
				 {
				 	temp_bio <- self.my_biomass;
				 	self.threshold <- self.temp_bio *myself.impact;
				 	self.my_color <-#orange;
				 }
		}
		
	}
	action Traitement
	{

		ask fields
		{
			if self.my_pest_tot >= 0.45  //GR1
			{
				list<float> list_impact_pesti <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_pesti_GR1)).x;
					add tmp to: list_impact_pesti;
				}
				self.impact <- mean(list_impact_pesti)/mean_biomass_RMQS ;
				write name + "pesti impact" + impact  ;
			}
			else if self.my_pest_tot < 0.45 //GR2
			{
				list<float> list_impact_pesti <- [];
				float tmp <- 1.0;
				loop times:30 
				{
					tmp <- any_location_in(geometry(histo_pesti_GR2)).x;
					add tmp to: list_impact_pesti;
				}
				self.impact <- mean(list_impact_pesti)/mean_biomass_RMQS ;
				write name + "pesti impact" + impact  ;
			}
			
			ask micro_cells
				 {
				 	temp_bio <- self.my_biomass;
				 	self.threshold <- self.temp_bio * myself.impact;
				 	self.my_color <-#purple;
				 }
		}
			
	}
	action Culture
	{
		ask fields.micro_cells 
		{
			sowing <- true;
			self.my_crop <- myself.crop;
			decade <- 1;
		}
		ask fields
		{
			self.previous_crop <- myself.crop;
		}
		
		write "***************CULTURE culture" + fields.previous_crop;

	}
	action Recolte
	{
		ask fields.micro_cells
			{
				sowing <- false;
				my_crop <- "";
				decade <- 0;
			}
	}
	
	map<string,unknown> serialize
	{
		return map<string,unknown>(["action_id"::action_id,"action_date"::self.date_practice.date,
		"owner"::self.fields.owner.name_exploit,
		"parcelle_id"::self.fields.name,
		"type_practice"::type_practice,
		"details_practice"::details_practice,
		"crop"::crop,
		"N"::N,
		"P"::P,
		"K"::K,
		"MG"::MG,
		"S"::S,
		"herbi"::herbi,
		"fongi"::fongi,
		"mollus"::mollus,
		"insect"::insect]);
	}	
	
	aspect base
	{
		if(is_activated)
		{
//		draw shape color:color_act;
		}
	}
	aspect icon 
	{
		if(is_activated) and current_date<date_practice+3#day
		{
			draw my_icon size: 200#m;
		}
		
	}
	
	
}
species Climate_context schedules:[]
{
	float RR;
	float ETP_P;
	date my_date;
	string bidule;
}
species Climate 
{
	map<date,Climate_context> climate_contexts <-map([]);
	Climate_context current_climate <-nil ; 
	float RR -> {current_climate.RR};
	float ETP_P -> {current_climate.ETP_P};
	
	reflex my_action when:execute_sub_reflex
	{
		do do_step;
	}
	action do_step
	{
		current_climate <- update_climate();
	}
	
	
	Climate_context update_climate
	{
		Climate_context res <- climate_contexts[current_date.date];
		return res=nil?current_climate:res;
	}	
}
species cells_micro_organisms 
{
	string my_plot;
	string id_cell;
	Field my_field;
	string my_field_name;
	string my_farmer;
	bool sowing;
	string my_crop;
	rgb my_color <- rgb(0,120,0);
	int recovery <- 1;
	int time_passed <- 0;
	int time_after_impact <-0;
	int RUM;
	float Clay;
	float Sand;
	float coeff_texture;
	float R1;
	float R2;
	float RU1;
	float RU2;
	float Kc;
	float my_ETM;
	float ETFF;
	int days_of_water_stress max:365 min:0 <- 0;
	int decade;
	float a_micro <- a_micro_growth;
	float k_carrying <- k_micro_carrying;
	float initial_biomass;
	float my_biomass;
	float biomass_RMQS;
	float ratio_biomass<- initial_biomass/biomass_RMQS ;
	float temp_bio;
	rgb color_ratio_biomass;
	rgb biogeo;
	float threshold;
	list<cells_micro_organisms> neighbourhood_1<-[];
	list<cells_micro_organisms> neighbourhood_2<-[];
		
	
	init
	{
		write "creation";
		Kc <- 0.0;
		decade <- 0;
		RU1 <- 20 * coeff_texture;
		RU2 <- RUM - RU1;
		R1 <- RU1/2; //réservoir à moitié plein
		R2 <- RU2;
		threshold <- k_carrying;
		my_biomass<-initial_biomass;
		if my_farmer = "888"
		{
			my_crop <- 'Foret';
			sowing <- true;
			decade <- 1;
		}
	}
	reflex do_all when:execute_sub_reflex
	{
		do do_step;
	}
	action do_step
	{
		do water_stress;
		if(sowing=true )
		{
			do ajust_kc;
		}
		
		if(recovery>1 and threshold>1 and temp_bio>0.0 and current_date.date > date("2011-09-25", "yyyy-MM-dd")) //date du 1er prélèvement en septembre 2011, initialisation de la biomasse
		//ne pose pas de problème pour serious game car il se déroule bien après le 26 sept 2011
		{
			do change_biomass;
		}
		
		if(recovery=1 and threshold>1 and temp_bio>0.0 and current_date.date > date("2011-09-25", "yyyy-MM-dd")) //date du 1er prélèvement en septembre 2011, initialisation de la biomasse
		//ne pose pas de problème pour serious game car il se déroule bien après le 26 sept 2011
		{
			do actualize_biomass_without_impact;
		}
		do ajust_recovery;
		if( current_date.date.day_of_year mod 10 =0  and recovery !=0 and sowing=true) //every(10 #days)
		{
			do count_decade ; 
		}
		if(since(starting_date.date + 1#year))
		{
			do change_year_restart_water_stress;
			
		}
		do update_ratio;
	
	}
 
	action update_ratio
	{
		ratio_biomass<-  my_biomass/biomass_RMQS ;
	
	}

	action water_stress 
	{
		map<string,float> res <- first(watterStorage.BH2R(list([climate.RR]),list([my_ETM]),RU1,RU2,R1,R2));
		R1 <- res["R1"];
		R2 <- res["R2"];
		ETFF <- res["ETR1"]+res["ETR2"]; //activité de la plante 
		if R1 = 0.0
		{
		days_of_water_stress <- days_of_water_stress + 1;	
		}
	}
	
	action ajust_kc 
	{
		plant p <- all_plants[self.my_crop][self.decade];
		if( p!=nil )
		{
			self.Kc <- p.kc_dec_crop;
		}
		my_ETM <- climate.ETP_P* Kc;
	}
	action ajust_recovery
	{
		if recovery>1
		{
			recovery <- recovery-1;
			time_passed <- time_passed +1;
			if sowing=true
			{
				sowing <- true;
			}
		}
		else if recovery=1 
		{ 
			ask my_field
			{
				impact <- 1.0;
			}
			if time_passed > 1
			{
			time_passed <- 0;
			temp_bio <- my_biomass;
			}
			if sowing=false
			{
			my_color <-rgb(0,120,0);
			}
			else if sowing=true
			{
			my_color <- rgb(0,240,0);
			}					
		}
		else if (recovery=1 and current_date.date > date("2011-09-25", "yyyy-MM-dd")) 
		{
			do actualize_biomass_without_impact;
		}
	}
	action actualize_biomass_without_impact
	{
		time_after_impact <- time_after_impact + 1;
		my_biomass<- k_carrying / (1+(k_carrying/temp_bio-1)*exp(-a_micro * time_after_impact));
	}
	action change_biomass
	{
		my_biomass<- threshold / (1+(threshold/temp_bio-1)*exp(-a_micro * time_passed));
	}
	
	
	action count_decade //when:  current_date.date.day_of_year mod 10 =0  and recovery !=0 and sowing=true //every(10 #days)
	{
		decade <- decade+1 ;
		if decade = 38
		{
			decade <- 1;
		}
	}
	action change_year_restart_water_stress// when:  since(starting_date.date + 1#year) //every(1#day)
	{
		if R1>0.0
		{
			days_of_water_stress <- days_of_water_stress-1;
		}
		
	}
	
	aspect base
	{
		draw shape color:my_color;	
	}
	
	
	aspect check_biomass
	{
		if 0.70<=ratio_biomass and ratio_biomass<=1.30
		{
			color_ratio_biomass <- rgb(0,0,255);
		}
		else if ratio_biomass < 0.70
		{
			color_ratio_biomass <- rgb(255,0,0);
		}
		else if ratio_biomass > 1.30
		{
			color_ratio_biomass <- rgb(0,255,0);
		}
		draw shape color:color_ratio_biomass;
	}
	
	aspect biomass_by_class
	{
		if my_biomass > 0 and my_biomass <= 16.0
		{
			biogeo <- rgb(255,0,0);  
		}
		else if my_biomass > 16.0 and my_biomass <= 24.0
		{
			biogeo <- rgb(248,80,80); 
		} 
		else if my_biomass > 24.0 and my_biomass <= 32.0
		{
			biogeo <- rgb(236,100,100); 
		} 
		else if my_biomass > 32.0 and my_biomass <= 40.0
		{
			biogeo <- rgb(234,120,88); 
		} 
		else if my_biomass > 40.0 and my_biomass <= 47.0
		{
			biogeo <- rgb(234,179,88); 
		} 
		else if my_biomass > 47.0 and my_biomass <=54.0
		{
			biogeo <- rgb(233,189,58); 
		} 
		else if my_biomass > 54.0 and my_biomass <= 61.0  //moyenne +-
		{
			biogeo <- rgb(231,206,29); 
		} 
		else if my_biomass > 61.0 and my_biomass <= 68.0
		{
			biogeo <- rgb(230,230,0);
		} 
		else if my_biomass > 68.0 and my_biomass <= 75.0
		{
			biogeo <- rgb(189,220,0);
		} 
		else if my_biomass > 75.0 and my_biomass <= 82.0
		{
			biogeo <- rgb(151,211,0);
		} 
		else if my_biomass > 82.0 and my_biomass <= 100.0
		{
			biogeo <- rgb(116,202,0);
		} 
		else if my_biomass > 100.0 and my_biomass <= 150.0
		{
			biogeo <- rgb(83,193,0);
		} 
		else if my_biomass > 150.0 and my_biomass <= 200.0
		{
			biogeo <- rgb(53,184,0);
		} 
		else if my_biomass > 200.0 and my_biomass <= 300.0
		{
			biogeo <- rgb(25,120,0);
		} 
		else if my_biomass > 300.0
		{
			biogeo <- rgb(0,100,0);
		} 
		draw shape color:biogeo;
	}
}

species plant schedules:[]
{
	int dec;
	string considered_crop;
	float kc_dec_crop;
	
	init
	{
		map<int,plant> tmp<-all_plants[considered_crop];
		if(all_plants[considered_crop] = nil)
		{
			tmp <- map<int,plant>([]);
			add tmp at:considered_crop to:all_plants;
		}
		add self at:dec to:tmp;

	}
}
experiment lanscape_scale type:gui
{	
	parameter "num_sim" var:number_sim <-141;
	parameter "time_impact_practice" var:time_impact <-3;
	parameter "a_growth_rate" var: a_micro_growth <- 0.000239823;
	parameter "K_carrying_capacity" var:k_micro_carrying <- 130.0;

	float minimum_cycle_duration <- 0.5#s;
	output 
	{
		display Fenay_classic type:opengl refresh:every(1#cycles)
			{
			species cells_micro_organisms aspect:base;
			species Field aspect:border_line;
			species actions aspect: icon;
			}
		display Fenay_biomass //refresh:every(365#cycles)
			{
			species cells_micro_organisms aspect:biomass_by_class;
			species Field aspect:border_line;
			}
	}
}

