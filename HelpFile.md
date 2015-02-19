# ExoPlanets Tool HELP

This Exoplanet Tool aims to provide a tool to help people exploring exoplanets data from different points of view and should be considered just as a first version model.

## Menu Bar

Exoplanets Tool is organized around four options available in the menu bar you can find at the top of the webpage. These Options are:

- **Tool**: access to the ExoPlanets Tool
- **CodeBook**: displays the interpretation of the variables used in the data an tool.
- **Help**: acces to this HELP
- **About**: a brief explanation of the aims of this application, the origin of the used data and a note on exoplanets.

### Tool

This option, *Tool*, is selected by default When the application starts. Here you'll find four tabs:

- **Table**: shows an exoplanets data table that allows filtering and searches.
- **Plot**: shows an scatter plot whose X and Y variables can be fully selected.
- **Histogram**: shows an histogram whose X variable can be fully selected.
- **KMeans**: applies KMeans algorithm to X and y variables (you can select any of the available) and present results in a scatter plot.


Every and each of these four tabs is organized this way:

- Left sidebar panel: here you'll find tools for filtering and selecting data to work with and how.
- Main panel: results are presented in this area.


#### Table Tab

- Left sidebar panel: Here you'll find all the variables in the dataset, each with a check button to select if it will be shown in the main panel data table.

- Main panel: a data table is shown, each column is one of the selected variables in the side bar panel. This data table allows:
    - Left over the table: customize the number of items shown by page
    - Right over thetable: Search box
    - Below the table: filter columns
    - Page navigation


#### Plot Tab

- Left sidebar panel is divided in two areas:
    - In the upper area you can:
        - Select variables to be shown in X and Y axis.
        - Select logarithmics scales for each axis.
    - In the lower area you can filter by the planet discovery method
    
- Main panel: a scatter plot is shown with the data selected in teh left side bar. Each point is X and Y selected variables for a planet, its shape and color depending on the discovery method with which the planet was found.

#### Histogram Tab

- Left sidebar panel is divided in three areas:
    - In the upper area you can:
        - Select the variable to be shown in the X axis.
        - Select logarithmics scales for each axis.
    - In the middle area you can filter by the planet discovery method
    - In the lower area you have a slider to play with the histogram bins width.
    
- Main panel: a scatter plot is shown with the data selected in the left side bar. Each point is X and Y selected variables for a planet, its shape and color depending on the discovery method with which the planet was found.

#### KMeans Tab

- Left sidebar panel is divided in three areas:
    - In the upper area you can:
        - Select the variable to be shown in the X axis.
        - Select logarithmics scales for each axis.
    - In the middle area you can filter by the planet discovery method
    - In the lower area you have a slider to play with the histogram bins width.
    
- Main panel: a scatter plot is shown with clusters differentiated by color.

### CodeBook
A simple text file with the definition and units in Exoplanets Data.

### Help
This Help.

### About
a brief explanation of the aims of this application, the origin of the used data and a note on exoplanets.
