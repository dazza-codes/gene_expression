#dataPath <- "C:/Documents and Settings/dweber.BUCKCENTER/My Documents/melovGeneExpression"
HOME <- Sys.getenv("HOME")
dataPath <- "src/melovGeneExpression"
dataPath <- file.path(HOME, dataPath)

dataFile <- "GSE12290.txt"

setwd(dataPath)

# Read the tab-delimited data file with a header
#x <- read.delim(dataFile, header=TRUE)
x <- read.table(dataFile, header=TRUE, as.is=TRUE)

# Extract the oligo values (these are unique)
oligo <- x[-(1),1]

# Extract the gene labels (these are not unique)
genes <- x[-(1),2]

# Extract the worm labels
#wormNames <- attr(x,"names")
#wormNames <- wormNames[-(1:2)]

# Extract the days old
#days <- x[1,]

# ----------------------------------------------------------
# Create subsets at each day old

day04 <- subset(x[-(1),], select = which(x[1,] == 04))
day08 <- subset(x[-(1),], select = which(x[1,] == 08))
day12 <- subset(x[-(1),], select = which(x[1,] == 12))
day14 <- subset(x[-(1),], select = which(x[1,] == 14))
day16 <- subset(x[-(1),], select = which(x[1,] == 16))
day20 <- subset(x[-(1),], select = which(x[1,] == 20))
day24 <- subset(x[-(1),], select = which(x[1,] == 24))

# Identify the worms for each day group
day04worms <- attr(day04, "names")
day08worms <- attr(day08, "names")
day12worms <- attr(day12, "names")
day14worms <- attr(day14, "names")
day16worms <- attr(day16, "names")
day20worms <- attr(day20, "names")
day24worms <- attr(day24, "names")

# Count the number of worms for each day group
day04n <- length(day04worms)
day08n <- length(day08worms)
day12n <- length(day12worms)
day14n <- length(day14worms)
day16n <- length(day16worms)
day20n <- length(day20worms)
day24n <- length(day24worms)

# Add the oligo and gene labels
day04 <- cbind(oligo, genes, day04)
day08 <- cbind(oligo, genes, day08)
day12 <- cbind(oligo, genes, day12)
day14 <- cbind(oligo, genes, day14)
day16 <- cbind(oligo, genes, day16)
day20 <- cbind(oligo, genes, day20)
day24 <- cbind(oligo, genes, day24)

# ----------------------------------------------------------
# Create summary statistics

day04mat <- data.matrix(day04[,-(1:2)])
day08mat <- data.matrix(day08[,-(1:2)])
day12mat <- data.matrix(day12[,-(1:2)])
day14mat <- data.matrix(day14[,-(1:2)])
day16mat <- data.matrix(day16[,-(1:2)])
day20mat <- data.matrix(day20[,-(1:2)])
day24mat <- data.matrix(day24[,-(1:2)])

day04means <- rowMeans(day04mat)
day08means <- rowMeans(day08mat)
day12means <- rowMeans(day12mat)
day14means <- rowMeans(day14mat)
day16means <- rowMeans(day16mat)
day20means <- rowMeans(day20mat)
day24means <- rowMeans(day24mat)

day04sd = apply(day04mat, 1, sd)
day08sd = apply(day08mat, 1, sd)
day12sd = apply(day12mat, 1, sd)
day14sd = apply(day14mat, 1, sd)
day16sd = apply(day16mat, 1, sd)
day20sd = apply(day20mat, 1, sd)
day24sd = apply(day24mat, 1, sd)

day04sem = day04sd / sqrt(day04n)
day08sem = day08sd / sqrt(day08n)
day12sem = day12sd / sqrt(day12n)
day14sem = day14sd / sqrt(day14n)
day16sem = day16sd / sqrt(day16n)
day20sem = day20sd / sqrt(day20n)
day24sem = day24sd / sqrt(day24n)


# Create plots

bgcolor <- "white" #  "transparent"
axiscolor <- "black"

dataColors <- c("red","dark green")
##dataColors <- c("green","red")

##       ps.options(paper="special",
##                  height=6.0,
##                  width=5.0,
##                  pointsize=10,
##                  horizontal=FALSE,
##                  onefile=FALSE)
ps.options(paper="letter",
         pointsize=14,
         horizontal=TRUE,
         onefile=FALSE)

baseFontSize <- 1.00      # multiply pointsize in ps.options
axisFontSize <- 1.2      # multiply baseFontSize
labelFontSize <- 1.4     # multiply baseFontSize
mainFontSize <- 1.6      # multiply baseFontSize


dayFactor <- gl(7,1,7, c("4","8","12","14","16","20","24"))

plotPath <- file.path(dataPath, "plots")


#ylabel <- expression(paste("Expression (", log[2], "; ", bar(x) %+-% s[bar(x)], ")"))
ylabel <- expression(paste("Expression (", log[2], ")", sep=""))

meanSEMex <- expression(bar(x) %+-% s[bar(x)])

for (i in seq(1,length(oligo))){
    geneLabel <- paste(genes[i], oligo[i], sep=" : ")
    print(geneLabel)
    
    #plotTitle <- call("expression", paste(geneLabel, " (", meanSEMex, ")", sep=""))
    #plotTitle <- paste(geneLabel, " (mean +/- sterr)", sep="")
    plotTitle <- geneLabel
    
    dayMeans <- c(
        day04means[i],
        day08means[i],
        day12means[i],
        day14means[i],
        day16means[i],
        day20means[i],
        day24means[i]
    )
    
    if (any(is.na(dayMeans))) {
        # There may be a way to plot this data, just by removing
        # the missing values and adjusting the plots.
        next
    } else {

        # output a mean +/- sem plot
        graphicsFile <- paste(genes[i], oligo[i], sep="_")
        graphicsFile <- paste(graphicsFile,".eps", sep = "")
        graphicsFile <- file.path(plotPath,graphicsFile)
        postscript(graphicsFile)
        
        par(bg=bgcolor, # background color.
            col=axiscolor, # the default plotting color.
            col.axis=axiscolor, # The color of axis annotation.
            col.lab=axiscolor, # The color of x and y labels.
            col.main=axiscolor, # The color of plot main titles.
            col.sub=axiscolor, # The color of plot sub-titles.
            
            cex=baseFontSize, # relative to pointsize in ps.options
            cex.main=mainFontSize, # relative to base font size
            cex.axis=axisFontSize, # relative to base font size
            cex.lab=labelFontSize, # relative to base font size
                                    # internal tick marks, xaxis tight
            tcl=0.5,
            tck=NA,
            mgp=c(3, 1, 0),  # axis (title, labels, line), default is 'c(3, 1, 0)'.
            mar=c(4, 5, 3, 1) + 0.1, #c(bottom, left, top, right)
            xaxs="i")

        dayValues <- c(
            day04mat[i,],
            day08mat[i,],
            day12mat[i,],
            day14mat[i,],
            day16mat[i,],
            day20mat[i,],
            day24mat[i,]
        )
        dayRange <- range(min(dayValues), max(dayValues))

        df <- data.frame(days=dayFactor, means=dayMeans)
        plot(df,
            type="p",
            xlab="days old",
            ylab=ylabel,
            ylim=dayRange,
            main=plotTitle)
        points(day04mat[i,]*0 + 1, day04mat[i,], pch='o')
        points(day08mat[i,]*0 + 2, day08mat[i,], pch='o')
        points(day12mat[i,]*0 + 3, day12mat[i,], pch='o')
        points(day14mat[i,]*0 + 4, day14mat[i,], pch='o')
        points(day16mat[i,]*0 + 5, day16mat[i,], pch='o')
        points(day20mat[i,]*0 + 6, day20mat[i,], pch='o')
        points(day24mat[i,]*0 + 7, day24mat[i,], pch='o')
        daySEM <- c(
            day04sem[i],
            day08sem[i],
            day12sem[i],
            day14sem[i],
            day16sem[i],
            day20sem[i],
            day24sem[i]
        )
        for (x in seq(1,7)){
            arrows(
                x,dayMeans[x]+daySEM[x],
                x,dayMeans[x]-daySEM[x],
                angle=90,code=3,length=.2)
        }
        graphics.off()
    }
    #if (i > 0) stop()
}

