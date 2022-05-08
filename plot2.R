library(chron)

# Download data set.

filename <- "exdata_data_household_power_consumption.zip"
path <- getwd()

# Checking if file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip(filename) 
}

# Read data set.

df <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";", )
df <- df[!apply(df == "?", 1, all),]
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$Time <- times(df$Time)
df[3:8] <- as.numeric(unlist(df[3:8]))
df_subset <- subset(df, Date == "2007-02-01" | Date == "2007-02-02")
df_subset$DT <- as.POSIXct(paste(df_subset$Date, df_subset$Time),format="%Y-%m-%d %H:%M:%S")
png(file = "plot2.png")
plot(df_subset$DT,df_subset$Global_active_power, type="l", col="black", lwd=1, xlab = "", ylab="Global Active Power (kilowatts)")
dev.off()
