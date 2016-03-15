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
storm_data$EVTYPE <- gsub(".*THUNDER.*", "THUNDERSTORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TSTM.*", "THUNDERSTORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*AVALA.*", "AVALANCHE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LIGHTN.*", "LIGHTNING", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub("FLOOD.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FLASH.*", "FLASH FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WINT.*", "WINTER STORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HURR.*", "HURRICANE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TYPHOON.*", "HURRICANE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SNOW.*", "WINTER STORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TROPI.*", "TROPICAL STORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FIRE.*", "WILDFIRE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FOG.*", "DENSE FOG", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*MARINE.*", "MARINE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WIND.*", "HIGH WIND", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*COLD.*", "COLD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HEAT.*", "HEAT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*BLACK.*", "WINTER WEATER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub("ICE.*", "WINTER WEATHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub("ICY.*", "WINTER WEATHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SURF.*", "HIGH SURF", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WARM.*", "HEAT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*GLAZE.*", "WINTER WEATHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*ICE.*", "WINTER WEATHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FREEZING.*", "WINTER WEATHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*RAIN.*", "HEAVY RAIN", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SEAS.*", "HIGH SURF", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*CURRENT.*", "RIP CURRENT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HYPO.*", "COLD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HYPER.*", "HEAT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*RISING.*", "FLASH FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*COASTAL.*", "MARINE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LOW.*", "COLD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*MIXED.*", "SLEET", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*ROGUE.*", "MARINE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HIGH WA.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*DROWNING.*", "OTHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SWEL.*", "HIGH SURF", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SWEL.*", "HIGH SURF", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SLIDE.*", "OTHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*MICRO.*", "HIGH WIND", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FLD.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TIDE.*", "STORM SURGE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FREEZE.*", "FROST/FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FROST.*", "FROST/FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HAIL.*", "HAIL", storm_data$EVTYPE)
storm_data <- storm_data[!(storm_data$EVTYPE == "HIGH"), ]

# Human cost

hstorm_data <- storm_data[!(storm_data$FATALITIES > 0 & storm_data$INJURIES > 0),]

htest_data <- hstorm_data %>%
        group_by(EVTYPE) %>%
        filter(FATALITIES > 0 | INJURIES > 0) %>%
        summarize(FATALITIES = sum(FATALITIES), INJURIES = sum(INJURIES), Total = sum(FATALITIES, INJURIES)) 



q1_data <- hstorm_data %>%
        group_by(EVTYPE) %>%
        summarize(FATALITIES = mean(FATALITIES), INJURIES = mean(INJURIES), Total = mean(FATALITIES + INJURIES)) %>%
        filter(FATALITIES > 0 | INJURIES > 0) %>%
        top_n(10, Total) %>%
        select(-Total) %>%
        melt(id.var = "EVTYPE")

q1_plot <- ggplot(q1_data, aes(x = EVTYPE, y = value, fill = variable)) +
        geom_bar(stat = "identity") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))

print(q1_plot)

# Financial cost

fstorm_data <- storm_data[!(storm_data$PROPDMG > 0 & storm_data$CROPDMG > 0),]

ftest_data <- fstorm_data %>%
        group_by(EVTYPE) %>%
        filter(FATALITIES > 0 | INJURIES > 0) %>%
        summarize(FATALITIES = sum(FATALITIES), INJURIES = sum(INJURIES), Total = sum(FATALITIES, INJURIES)) 
