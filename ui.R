library(markdown)
library(shiny)
library(ggplot2)  
library(shiny)
source("init.R")
init()

shinyUI(navbarPage(
    title = 'ExoPlanets',
    tabPanel("Tool",
        sidebarLayout(
            wellPanel(
                tags$style(type="text/css", 
                           '#leftPanel { width:200px; float:left;}'),
                id = "leftPanel",
                conditionalPanel(
                    'input.dataset === "Table"',
                    checkboxGroupInput('show_vars', h3('Features to show:'),
                                       names(rawExoData), 
                                       selected = selected_table),
                    hr(),
                    helpText(a('Data',
                               href = "https://raw.githubusercontent.com/OpenExoplanetCatalogue/oec_tables/master/comma_separated/open_exoplanet_catalogue.txt"),
                             'from ', 
                             a('Exoplanets', 
                               href="http://www.openexoplanetcatalogue.com/"), 
                                  'Select in the above list the planetary features to 
                                  show in table columns . 
                                  You can order the table by column, search, customize table pages
                                  length and filter by each column.')
                         ),
                conditionalPanel(
                    'input.dataset === "Plot"',
                    selectInput('x_var', h3('X Variable'), names_plot,
                                selected = names_plot[4]),
                    checkboxInput('show_log_x', 
                                  'Logarithmic X-Scale', 
                                  value = TRUE),
                    hr(),
                    selectInput('y_var', h3('Y Variable'), names_plot,
                                selected = names_plot[1]),
                    checkboxInput('show_log_y', 
                                  'Logarithmic Y-Scale', 
                                  value = TRUE),
                    hr(),
                    checkboxGroupInput('show_method', h3('Discovery Method:'),
                                       names_methods, selected = names_methods),
                    hr(),
                    helpText('Select in the above list the required exoplanets
                                  discovery methods. Select also the features to use
                                  in X and Y axis. You can use logarithmic scales in both 
                                  axis.')
                    ),
                conditionalPanel(
                    'input.dataset === "Histogram"',
                    selectInput('xh_var', h3('X Axis'), names_plot,
                                selected = names_plot[9]),
                    checkboxInput('show_log_xh', 
                                  'Logarithmic X-Scale',
                                  value = FALSE),
                    hr(),
                    checkboxInput('show_log_yh', 
                                  'Logarithmic Y-Scale',
                                  value = FALSE),
                    hr(),
                    checkboxGroupInput('show_method_h', h3('Discovery Method:'),
                                       names_methods, selected = names_methods),
                    hr(),
                    sliderInput("slider_h", label = h3("Slider"), min = 1, 
                                max = 200, value = 100),
                    hr(),
                    helpText('Select the count to use in the histogram X-axis.You 
                                  can choose logarithmic scales in both axis and select the
                                  planets dicovery method. Slider is to customize the number
                                  of bins in the histogram.')
                         ),
                conditionalPanel(
                    'input.dataset === "KMeans"',
                    selectInput('xk_var', h3('X Var'), names_plot,
                                selected = names_plot[4]),
                    hr(),
                    selectInput('yk_var', h3('Y Var'), names_plot,
                                selected = names_plot[1]),
                    numericInput('clusters', h3('Cluster count'), 3,
                                 min = 1, max = 9, step = 1),
                    hr(),
                    helpText('Select the X and Y variables on which perform 
                             KMeans algorithm and the number of clusters
                             it must separate.')
                    )
                ),
                 mainPanel(
                     tabsetPanel(
                         id = 'dataset',
                         tabPanel('Table', dataTableOutput('mytable')),
                         tabPanel('Plot', plotOutput('myplot')),
                         tabPanel('Histogram', plotOutput('myhistogram')),
                         tabPanel('KMeans', plotOutput('mykmeans'))
                         )
                     )
            )
    ),
    tabPanel("CodeBook", 
             verbatimTextOutput("codebook")
    ),

    tabPanel("Help",
             includeMarkdown("HelpFile.md")
    ),
    tabPanel("About",
             fluidRow(
                 column(6,
                        includeMarkdown("about.md")
                 ),
                 column(3,
                        img(class="img-polaroid",
                            src=paste0("http://upload.wikimedia.org/",
                                       "wikipedia/commons/e/ea/",
                                       "Planeta_extrasolar_y_satelite_similar_a_la_tierra.jpg"),
                            height = 320, width = 450
                        ),
                        tags$small(
                            "Source: Extrasolar giant planet and an ",
                            "earth-like moon or satelite with vasts oceans ",
                            "of water, and with a temperature range suitable ",
                            "for life (within the habitable zone) by ",
                            "Lucianomendez (Own work) ",
                            a(href="http://www.gnu.org/copyleft/fdl.html", "GFDL"), 
                            "or",
                            a(href="http://creativecommons.org/licenses/by-sa/4.0-3.0-2.5-2.0-1.0", "CC BY-SA 4.0-3.0-2.5-2.0-1.0"), 
                            a(href="http://commons.wikimedia.org/wiki/File%3APlaneta_extrasolar_y_satelite_similar_a_la_tierra.jpg", "via Wikimedia Commons")

                        )
                 )
             )
    )
    
))