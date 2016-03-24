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

storm_data <- select(storm_data, EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP,
                     CROPDMG, CROPDMGEXP)

storm_data$EVTYPE <- storm_data$EVTYPE %>%
        toupper() %>%
        as.factor()

storm_data$PROPDMGEXP <- toupper(storm_data$PROPDMGEXP)
storm_data$CROPDMGEXP <- toupper(storm_data$CROPDMGEXP)

storm_data$EVTYPE <- gsub("/"," ", storm_data$EVTYPE) 


storm_data$EVTYPE <- gsub(".*TORNADO.*", "TORNADO", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TORNDAO.*", "TORNADO", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LANDSPO.*", "TORNADO", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*THUNDER.*", "THUNDERSTORM WIND", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TSTM.*", "THUNDERSTORM WIND", storm_data$EVTYPE)
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
storm_data$EVTYPE <- gsub(".*COLD.*", "COLD/WIND CHILL", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HEAT.*", "HEAT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*BLACK.*", "WINTER WEATHER", storm_data$EVTYPE)
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
storm_data$EVTYPE <- gsub(".*COASTAL.*FLOO.*", "COASTAL FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LOW.*", "COLD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*MIX.*", "WINTER WEATHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*ROGUE.*", "MARINE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HIGH WA.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*DROWNING.*", "OTHER", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SWEL.*", "HIGH SURF", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*CSTL.*", "COSTAL FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SLIDE.*", "DEBRIS FLOW", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*MICRO.*", "HIGH WIND", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FLD.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*TID.*", "STORM SURGE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FREEZE.*", "FROST/FREEZE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FROST.*", "FROST/FREEZE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HAIL.*", "HAIL", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*RIVER.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*MINOR.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*STREAM.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WETNESS.*", "HEAVY RAIN", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*MAJOR.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WATERSPOUT.*", "WATERSPOUT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WAYTERSPOUT.*", "WATERSPOUT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WATER SPOUT.*", "WATERSPOUT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*BEACH.*", "BEACH EROSION", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*BLIZZARD.*", "BLIZZARD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*FUNNEL.*", "FUNNEL CLOUD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HEAVY PRECIP.*", "HEAVY RAIN", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*EXCESSIVE PRECIP.*", "HEAVY RAIN", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*DRY.*", "DROUGHT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*DUST D.*", "DUST DEVIL", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*DUST.*S.*", "DUST STORM", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SHOWER*", "HEAVY RAIN", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HEAVY RAIN.*", "HEAVY RAIN", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HOT.*", "HEAT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*HIGH TEMP.*", "HEAT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LIGHT.*", "LIGHTNING", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LIGN.*", "LIGHTNING", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*DAM.*", "FLASH FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*BREAK.*", "FLASH FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LAKE.*FLOOD.*", "LAKESHORE FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*GUSTNA.*", "THUNDERSTORM WIND", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*RECORD HIGH.*", "HEAT", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*SLEET.*", "SLEET", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*WND.*", "STRONG WIND", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*VOLCAN.*", "VOLCANIC ASH", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*VOG.*", "DENSE FOG", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*URBAN.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*RURAL.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*STREET.*", "FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*COST.*", "COASTAL FLOOD", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*COASTAL.*S.*", "MARINE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*COASTAL ERO.*", "MARINE", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*COOL.*", "COLD/WIND CHILL", storm_data$EVTYPE)
storm_data$EVTYPE <- gsub(".*LANDS.*", "HEAVY RAIN", storm_data$EVTYPE)



storm_data <- storm_data[!(storm_data$EVTYPE == "HIGH"), ]

test_data <- storm_data %>%
        group_by(EVTYPE) %>%
        summarise(Fatalities = mean(FATALITIES))

storm_data$PROPDMGEXP <- gsub("0", "1", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("B", "1000000", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("K", "1000", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("M", "100000", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("H", "100", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("2", "100", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("3", "1000", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("4", "10000", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("5", "100000", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("6", "1000000", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("7", "10000000", storm_data$PROPDMGEXP)
storm_data$PROPDMGEXP <- gsub("-", "1", storm_data$PROPDMGEXP)

storm_data$CROPDMGEXP <- gsub("0", "1", storm_data$CROPDMGEXP)
storm_data$CROPDMGEXP <- gsub("B", "1000000", storm_data$CROPDMGEXP)
storm_data$CROPDMGEXP <- gsub("K", "1000", storm_data$CROPDMGEXP)
storm_data$CROPDMGEXP <- gsub("M", "100000", storm_data$CROPDMGEXP)

storm_data$CROPDMGEXP <- as.numeric(storm_data$CROPDMGEXP)
storm_data$PROPDMGEXP <- as.numeric(storm_data$PROPDMGEXP)

storm_data$PROPDMGEXP[is.na(storm_data$PROPDMGEXP)] <- 1
storm_data$CROPDMGEXP[is.na(storm_data$CROPDMGEXP)] <- 1


# Human cost

# hstorm_data <- storm_data[!(storm_data$FATALITIES == 0 & storm_data$INJURIES == 0),]

q1_data <- storm_data %>%
        group_by(EVTYPE) %>%
        summarize(Fatalities = mean(FATALITIES), Injuries = mean(INJURIES), Total = mean(FATALITIES + INJURIES)) %>%
        top_n(10, Total) %>%
        select(-Total) %>%
        melt(id.var = "EVTYPE")

q1_plot <- ggplot(q1_data, aes(x = reorder(EVTYPE, value, sum), y = value, fill = variable)) +
        geom_bar(stat = "identity") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Top 10 Most Harmful Weather Events", y = "Mean Casulity Number", x = "Event Type" ) +
        scale_fill_manual(values = c("firebrick4", "yellow4"), name = "Casulity Type")

print(q1_plot)

# Financial cost

# fstorm_data <- storm_data[!(storm_data$PROPDMG == 0 & storm_data$CROPDMG == 0),]


q2_data <- storm_data %>%
        mutate(CROPDMG = (CROPDMG*CROPDMGEXP)/10^6) %>%
        mutate(PROPDMG = (PROPDMG*PROPDMGEXP)/10^6) %>%
        group_by(EVTYPE) %>%
        summarise(Property = mean(PROPDMG), Crop = mean(CROPDMG), Total = mean(PROPDMG + CROPDMG)) %>%
        top_n(10, Total) %>%
        select(-Total) %>%
        melt(id.var = "EVTYPE")

q2_plot <- ggplot(q2_data, aes(x = reorder(EVTYPE, value, sum), y = value, fill = variable)) +
        geom_bar(stat = "identity") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        scale_fill_manual(values = c("cadetblue4", "darkolivegreen3"), name = "Damage Type") +
        labs(title = "Top 10 Costliest Weather Events", y = "Mean Cost (millions USD)", x = "Event Type" )

print(q2_plot)
