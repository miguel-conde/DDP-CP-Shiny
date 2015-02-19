init <- function() {
    
    library(shiny)
    library(ggplot2)
    library(scales) 

    
    # First, we read the file and load raw data:
    
    dataDirectory <- file.path(".","data")
    myExoURL <- "https://raw.githubusercontent.com/OpenExoplanetCatalogue/oec_tables/master/comma_separated/open_exoplanet_catalogue.txt"
    
    exoFile <- file.path(dataDirectory, "open_exoplanet_catalogue.txt")
    
    
    if(!file.exists(dataDirectory)) {
        dir.create(dataDirectory)
    }
    
    if (!file.exists(exoFile)) {
        download.file(url = myExoURL, destfile = exoFile)
    }
    
    
    #read the data
    rawExoData <<- read.table(exoFile, header = FALSE, sep = ",", 
                              stringsAsFactors = FALSE)
    
    names(rawExoData) <<- c("PrimId", "BinFlag", "PMassJ", "PRadiusJ", "Period", 
                            "SemiMajorAxis", "Eccentricity", "Periastron",
                            "Longitude", "AscNode","Inclination", "Temperature", 
                            "Age", "DiscoveryMethod", "DiscoveryYear", "LastUpdated",
                            "RA", "Dec", "DistanceFromSun", "HStarMassS", "HStarRadiusS", 
                            "HStarMetallicityS","HStarTemperature", "HStarAge")
    
    selected_table <<- c("PrimId", "PMassJ", "PRadiusJ", "Period", 
                         "SemiMajorAxis", "Eccentricity", "Temperature", 
                         "DiscoveryMethod", "DiscoveryYear","DistanceFromSun", 
                         "HStarMassS", "HStarTemperature")
    
    names_plot <<- c("PMassJ", "PRadiusJ", "Period", 
                     "SemiMajorAxis", "Eccentricity", "Inclination", "Temperature", 
                     "Age", "DiscoveryYear", 
                     "DistanceFromSun", "HStarMassS", "HStarRadiusS", 
                     "HStarMetallicityS","HStarTemperature", "HStarAge")
    
    #     good <- !is.na(rawExoData$DiscoveryYear) & rawExoData$DiscoveryYear > 1980
    #     rawExoData <<- rawExoData[good, ]
    
    rawExoData[rawExoData$DiscoveryMethod == "", ]$DiscoveryMethod <<- "others"
    
    names_methods <<- unique(rawExoData$DiscoveryMethod)
    
    codeBook <<- "# Columns: "
    
}