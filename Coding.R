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
        # as.character() %>%
        toupper() %>%
        as.factor()

storm_data$EVTYPE <- gsub("/"," ", storm_data$EVTYPE) 

storm_data$EVTYPE <- gsub(".*TORNADO.*", "TORNADO", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*THUNDERST.*", "THUNDERSTORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TSTM.*", "THUNDERSTORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*AVALA.*", "AVALANCHE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FLASH.*", "FLASH FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LIGHTN.*", "LIGHTNING", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub("FLOOD.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WINTE.*", "WINTER STORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HURRICANE.*", "HURRICANE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TYPHOON.*", "HURRICANE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SNOW.*", "WINTER STORM", storm_data$EVTYPE)

# from <- list(".*TORNADO.*", ".*THUNDERST.*", ".*TSTM.*",".*AVALA.*", ".*FLASH.*",
#       ".*LIGHTN.*", "FLOOD.*", ".*WINTE.*", ".*HURRICANE.*", ".*TYPHOON.*",".*SNOW.*"
#             )
# to <- c("TORNADO","THUNDERSTORM","THUNDERSTORM","AVALANCHE","FLASH FLOOD","LIGHTNING",
#       "FLOOD", "WINTER STORM", "HURRICANE","HURRICANE", "WINTER STORM")
# 
# find.in.list <- function(x, y) match(TRUE, sapply(y, `%in%`, x = x))
# idx.in.list  <- sapply(levels(storm_data$EVTYPE), find.in.list, from)
# levels(storm_data$EVTYPE)  <- ifelse(is.na(idx.in.list), levels(storm_data$EVTYPE), to[idx.in.list])



test_data <- storm_data %>%
        group_by(EVTYPE) %>%
        summarize(FATALITIES = sum(FATALITIES), INJURIES = sum(INJURIES), Total = sum(FATALITIES, INJURIES)) %>%
        filter(FATALITIES > 0 | INJURIES > 0)

q1_data <- storm_data %>%
        group_by(EVTYPE) %>%
        summarize(FATALITIES = mean(FATALITIES), INJURIES = mean(INJURIES), Total = sum(FATALITIES, INJURIES)) %>%
        filter(FATALITIES > 0 | INJURIES > 0) %>%
        top_n(10, Total) %>%
        select(-Total) %>%
        melt(id.var = "EVTYPE")

# q1_plot <- ggplot(q1_data, aes(x = EVTYPE, y = value, fill = variable)) +
#         geom_bar(stat = "identity") +
#         theme(axis.text.x = element_text(angle = 90, hjust = 1))
# 
# print(q1_plot)

