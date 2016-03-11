require(dplyr)
require(tidyr)
require(ggplot2)
require(reshape2)

if (!file.exists("storm_data.csv.bz2")) {

        file_url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
        download.file(file_url, "storm_data.csv.bz2", mode = "wb")
        dltimestamp <- Sys.time()
}

if (!exists("storm_data")) {
storm_data <- read.csv("storm_data.csv.bz2")
}

copy_data <- storm_data

storm_data$EVTYPE <- storm_data$EVTYPE %>%
        as.character() %>%
        toupper()

storm_data$EVTYPE <- gsub("/"," ", storm_data$EVTYPE) 

test_data <- count(storm_data, EVTYPE)

q1_data <- storm_data %>%
        group_by(EVTYPE) %>%
        summarize(FATALITIES = mean(FATALITIES), INJURIES = mean(INJURIES), Total = sum(FATALITIES, INJURIES)) %>%
        filter(FATALITIES > 0 | INJURIES > 0) %>%
        top_n(10, Total) %>% 
        select(-Total) %>%
        melt(id.var = "EVTYPE")

q1_plot <- ggplot(q1_data, aes(x = EVTYPE, y = value, fill = variable)) +
        geom_bar(stat = "identity")+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))

print(q1_plot)

