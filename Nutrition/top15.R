data <- read.csv('./data/nutritionInfo.csv')

# Look at data ------------------------------------------------------------
library(stringr)
data$ShorterD <- sub('\\s*,.*','', data$Shrt_Desc)


# Look at values ----------------------------------------------------------
counts <- table(data$ShorterD)
counts <- counts[order(counts,decreasing=TRUE)]
counts <- counts[1:15]
top15 <- names(counts)
               

# Pare down into these top 15 groups --------------------------------------

data <- data[data$ShorterD %in% top15,]



