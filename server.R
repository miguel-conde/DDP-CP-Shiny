library(shiny)
library(shiny)
source("init.R")
init()

shinyServer(function(input, output, session) {
    
    ## Reactives for Table
    dataTable <- reactive({
        rawExoData[, input$show_vars, drop = FALSE]
    })
    
    ## Reactives for Plot
    
    x_Plot <- reactive({
        input$x_var
    })
    
    y_Plot <- reactive({
        input$y_var
    })
    
    dataPlot <- reactive({
        rawExoData[rawExoData$DiscoveryMethod %in% input$show_method, 
                   , drop = FALSE]
    })
    
    
    x_log_Plot <- reactive({
        input$show_log_x
    })
    
    y_log_Plot <- reactive({
        input$show_log_y
    })
    
    ## Reactives for Histogram
    dataHistogram <- reactive({
        rawExoData[rawExoData$DiscoveryMethod %in% input$show_method_h &
                       rawExoData$DiscoveryYear > 1980  , 
                   , drop = FALSE]
    })
    
    dataRangeHistogram <- reactive({
        range(rawExoData[rawExoData$DiscoveryMethod %in% input$show_method_h &
                             rawExoData$DiscoveryYear > 1980  , 
                         input$xh_var, drop = FALSE], na.rm = T)
    })
    
    dataSliderHistogram <- reactive({
        input$slider_h
    })
    
    x_Histogram <- reactive({
        input$xh_var
    })
    
    x_log_Histogram <- reactive({
        input$show_log_xh
    })
    
    y_log_Histogram <- reactive({
        input$show_log_yh
    })
    
    ## Reactives for KMeans
    
    selectedData <- reactive({
        good <- !is.na(rawExoData[, input$xk_var]) & 
            !is.na(rawExoData[, input$yk_var]) & 
            !is.na(rawExoData[, "DiscoveryMethod"])
        rawExoData[good, c(input$xk_var, input$yk_var, "DiscoveryMethod"), 
                   drop = FALSE]
    })
    
    k_sel_methods <- reactive({
        good <- !is.na(rawExoData[, input$xk_var]) & 
            !is.na(rawExoData[, input$yk_var]) & 
            !is.na(rawExoData[, "DiscoveryMethod"])
        rawExoData[good, "DiscoveryMethod", 
                   drop = FALSE]
    })
    
    clusters <- reactive({
        kmeans(selectedData()[, c(input$xk_var, input$yk_var)], input$clusters)
    })
    
    ## RENDER Table
    output$mytable <- renderDataTable({
        dataTable()
    }, options = list(orderClasses = TRUE, pageLength = 10))
    
    ## RENDER Plot
    output$myplot <- renderPlot({
        
        dd <- dataPlot()
        xs <- x_Plot()
        ys <- y_Plot()
        dd <- dd[!is.na(dd[,xs]) & !is.na(dd[,ys]), ]
        
        p <- ggplot(data = dd,
                    aes_string(x = xs, y = ys),
        ) + 
            geom_point(size = 4, 
                       aes(colour = DiscoveryMethod,
                           fill = DiscoveryMethod,
                           shape = DiscoveryMethod)) +
            scale_colour_hue(l = 40) + # Use a slightly darker palette than normal
            scale_fill_hue(l = 40) 
        
        if (x_log_Plot() == TRUE) {
            p <- p + scale_x_continuous(trans = log10_trans())  # Need the scales package
        }
        else {
            rango <- range(dd[,xs],na.rm=T)
            p <- p + scale_x_continuous(trans = identity_trans())
        }
        
        if (y_log_Plot() == TRUE)
            p <- p + scale_y_continuous(trans = log10_trans())  # Need the scales package
        else {
            p <- p + scale_y_continuous(trans = identity_trans())
        }
        
        print(p)
    }, height = 600, width = 800)
    
    
    ## RENDER Histogram
    output$myhistogram <- renderPlot({
        
        dd <- dataHistogram()
        dd <- dd[dd$DiscoveryYear > 1980, ]

        r <- range(dataRangeHistogram(), na.rm = T)
        rango <- r[2] - r[1] + 1
        brk <- min(dataSliderHistogram(),rango)
        
        b_w <-  (rango / brk)
        
        p <- ggplot(data = dd, 
                    aes_string(x = x_Histogram())) + 
            geom_bar(stat="bin", 
                     binwidth = b_w,
                     colour = "black", aes(fill = DiscoveryMethod)) +
            xlab(input$xh_var) +
            ylab("Number of planets")
        
        if (x_log_Histogram() == TRUE) {
            p <- p + scale_x_continuous(trans = log10_trans()) 
        }
        else {
            p <- p + scale_x_continuous(trans = identity_trans()) 
        }
        if (y_log_Histogram() == TRUE)
            p <- p + scale_y_continuous(trans = log10_trans())  # Need the scales package
        
        print(p)
    }, height = 600, width = 800)
    
    
    # RENDER K-Means
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    output$mykmeans <- renderPlot({
        
        data <- selectedData()
        cluster <-clusters()$cluster
        centers <- clusters()$centers
        sel_methods <- k_sel_methods()
        data$DiscoveryMethod <- (sel_methods)
        
        p <- ggplot(data = data,
                    aes_string(x = input$xk_var, y = input$yk_var)) +
            geom_point(size = 6, colour = cluster, 
                       #                       shape = cluster,
                       fill = factor(cluster))
        
        p <- p + geom_point(data = as.data.frame(centers), 
                            aes_string(x = input$xk_var, y = input$yk_var),
                            size = 10, shape = 4, cex = 20)
        
        p <- p + scale_colour_hue(l = 40) + 
            scale_fill_hue(l = 40) +
            geom_smooth(method = lm, se = TRUE) +
            scale_y_continuous(trans = log10_trans()) + 
            scale_x_continuous(trans = log10_trans())
        
        print(p)
        
    }, height = 600, width = 800)
    
    output$codebook <- renderPrint({
        h2("Exoplanets Code Book")
        pre(includeText("CodeBook.txt"))
    })
    
})