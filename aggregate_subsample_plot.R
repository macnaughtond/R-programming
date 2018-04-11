setwd("C:\\Users\\David\\Desktop\\Apsim73\\Regions\\M_W_region\\Out_files")
filesList <- list.files()
df <- data.frame(FileName=character(),Year=character(), Drainage=double(), Runoff=double(), Canefw=double())
#print(filesList[4])
for( j in 1:length(filesList)) #
{
	#fileToRead = "C:\\Users\\David\\Desktop\\Apsim73\\Regions\\M_W_region\\Out_files\\coomAfAfAf_1970_14735_ADJ_1902_BU_RC6_delta_w2 daily.out"
	all_content = readLines(filesList[j]) # this is all of the data in the file
	all_data_except_second_row = all_content[-2]  # The -2 index just deletes the second row 
	data =  read.csv(textConnection(all_data_except_second_row), header = TRUE, stringsAsFactors = FALSE) # This variable is a data frame (a number of named column vectors of the same length but can have different types like string or integer)

	DrainAccumulator = 0
	RunoffAccumulator = 0
	canefreshweightMax = 0
	SoilLossAccumulator = 0
	latestCaneFreshWeight = 0
	current_year <- substr(data$todaydate[1],8,11)
	#TODO Add other variables here

	for(i in 1:nrow(data)){
		#print(i)
		year = substr(data$todaydate[i],8,11)
		if (!year %in% current_year){
			
			de <- data.frame( FileName=filesList[j], Year=current_year, Drainage=DrainAccumulator, Runoff=RunoffAccumulator, Soilloss=double(), Canefw=canefreshweightMax )
			df = rbind(df,de, stringsAsFactors=FALSE)
			# Reset the accumulators
			DrainAccumulator = 0
			RunoffAccumulator = 0
			SoilLossAccumulator = 0
			canefreshweightMax = 0
		}
		#do calcs
		latestCaneFreshWeight = data$canefw[i]
		if ( latestCaneFreshWeight > canefreshweightMax ){
			canefreshweightMax <- latestCaneFreshWeight 
		}
		DrainAccumulator += data$Drainage[i] # Alternatively write in shorthand: DrainAccumulator += data$Drainage[i]
		RunoffAccumulator += data$Runoff[i]
		SoilLossAccumulator +=  data$soil_loss
		current_year <- year

	}
	de <- data.frame( FileName=filesList[j], Year=current_year, Drainage=DrainAccumulator, Runoff=RunoffAccumulator, Soilloss = SoilLossAccumulator, Canefw=canefreshweightMax )
	df = rbind(df,de, stringsAsFactors=FALSE)
	print(j)
}
# Write filtered data into a new file.
write.csv(df,"C:\\Users\\David\\Desktop\\Apsim73\\Regions\\M_W_region\\output.csv", row.names = FALSE)

# Subsample the data to make plotting less time consuming and cluttered
nRowsToPlot = 200
dg <- df[sample(nrow(df), nRowsToPlot ), ]


# TODO: 
# 1. Insert here code to product the results for Simulator 7.9, 
# 2. Change names for data from Simulator versions 7.3 if you like to make the graphical intent clearer
# 3. Column bind the results of 7.9 adding to the file for 7.3. Ensure models scenarios align.

# Now plot
plot(x = dg$Drainage,y = dg$Drainage79,
   xlab = "ML/ha",
   ylab = "ML/ha",		 
   main = "Drainage Validation"
)
plot(x = dg$Runoff,y = dg$Runoff79,
   xlab = "ML/ha",
   ylab = "ML/ha",		 
   main = "Runoff Validation"
)
plot(x = dg$Soiloss,y = dg$Soilloss79,
   xlab = "t/ha",
   ylab = "t/ha",		 
   main = "Soil Loss Validation"
)

