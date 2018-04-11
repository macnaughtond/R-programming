#This R script calculates calendar year averages of basic paddock simulation results and writes them to a csv file
#Change the line below to suit your file structure
#Set the Working Directory to the Input files directory
setwd("C:\\Users\\David\\Desktop\\Apsim73\\Regions\\M_W_region\\Out_files")

filesList <- list.files() #Lists all of the files in the the working directory

#Create a data frame called df <-data.frame(var1Name=character(),.. nominate variable names and type)
df <- data.frame(FileName=character(),FirstYear=character(), LastYear=character(),Drainage=double(), Runoff=double(), Soilloss=double(), Canefw=double())

for( j in 1:length(filesList)) 
{

	all_content = readLines(filesList[j]) # this is all of the data in the file
	all_data_except_second_row = all_content[-2]  # The -2 index just deletes the second row 
	data =  read.csv(textConnection(all_data_except_second_row), header = TRUE, stringsAsFactors = FALSE) # This variable is a data frame (a number of named column vectors of the same length but can have different types like string or integer)

	FirstYear = as.numeric(min(substr(data$todaydate,8,11)))
	LastYear = as.numeric(max(substr(data$todaydate,8,11)))

	numYears = LastYear-FirstYear+1

	#YearRange = paste (as.character(LastYear),as.character(FirstYear), collapse="-")

	anAveDrainage <- sum(data$Drainage)/numYears
	anAveRunoff <- sum(data$Runoff)/numYears
	anAveSoilloss <- sum(data$soil_loss)/numYears
	canefreshweightMax <- max(data$canefw, na.rm=TRUE)
	
	de <- data.frame( FileName=filesList[j], FirstYear=FirstYear, LastYear=LastYear, Drainage=anAveDrainage, Runoff=anAveRunoff, Soilloss=anAveSoilloss, Canefw=canefreshweightMax )
	df = rbind(df,de, stringsAsFactors=FALSE)
	print(j)
}
# Write filtered data into a new file.

#Change the line below to suit your file structure
#Saving the Results File
write.csv(df,"C:\\Users\\David\\Desktop\\Apsim73\\Regions\\M_W_region\\AveragesOfOutFiles.csv", row.names = FALSE)

=======


#Change the line below to suit your file structure
#Set the Working Directory to the Input files directory
setwd("C:\\Users\\David\\Desktop\\Apsim73\\Regions\\M_W_region\\Out_files")

filesList <- list.files() #Lists all of the files in the the working directory

#Create a data frame called df <-data.frame(var1Name=character(),.. nominate variable names and type)
df <- data.frame(FileName=character(),FirstYear=character(), LastYear=character(),Drainage=double(), Runoff=double(), Soilloss=double(), Canefw=double())

for( j in 1:length(filesList)) 
{

	all_content = readLines(filesList[j]) # this is all of the data in the file
	all_data_except_second_row = all_content[-2]  # The -2 index just deletes the second row 
	data =  read.csv(textConnection(all_data_except_second_row), header = TRUE, stringsAsFactors = FALSE) # This variable is a data frame (a number of named column vectors of the same length but can have different types like string or integer)

	FirstYear = as.numeric(min(substr(data$todaydate,8,11)))
	LastYear = as.numeric(max(substr(data$todaydate,8,11)))

	numYears = LastYear-FirstYear+1

	#YearRange = paste (as.character(LastYear),as.character(FirstYear), collapse="-")

	anAveDrainage <- sum(data$Drainage)/numYears
	anAveRunoff <- sum(data$Runoff)/numYears
	anAveSoilloss <- sum(data$soil_loss)/numYears
	canefreshweightMax <- max(data$canefw, na.rm=TRUE)
	
	de <- data.frame( FileName=filesList[j], FirstYear=FirstYear, LastYear=LastYear, Drainage=anAveDrainage, Runoff=anAveRunoff, Soilloss=anAveSoilloss, Canefw=canefreshweightMax )
	df = rbind(df,de, stringsAsFactors=FALSE)
	print(j)
}
# Write filtered data into a new file.

#Change the line below to suit your file structure
#Saving the Results File
write.csv(df,"C:\\Users\\David\\Desktop\\Apsim73\\Regions\\M_W_region\\AveragesOfOutFiles.csv", row.names = FALSE)

