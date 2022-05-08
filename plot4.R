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
png(file = "plot4.png")
par(mfrow = c(2,2))
par(mar = c(3,3,2,2))
plot(df_subset$DT,df_subset$Global_active_power, type="l", col="black", lwd=1, xlab = "", ylab="", cex.lab = 0.6, cex.sub = 0.6, cex.axis = 0.8)
mtext("Global Active Power (kilowatts)", side=2, line=2, cex = 0.8)
plot(df_subset$DT,df_subset$Voltage, type="l", col="black", lwd=1, xlab = "", ylab="", yaxt="n",cex.lab = 0.6, cex.sub = 0.6, cex.axis = 0.8)
ytick<-seq(234, 246, by=4)
axis(side=2, at=ytick, labels = ytick)
mtext("datetime", side=1, line=2, cex = 0.8)
mtext("Voltage", side=2, line=2, cex = 0.8)
plot(df_subset$DT,df_subset$Sub_metering_1, type="l", col="black", lwd=1, xlab = "", ylab="", cex.lab = 0.6, cex.sub = 0.6, cex.axis = 0.8)
lines(df_subset$DT, df_subset$Sub_metering_2, type = "l", col = "red", lwd=1)
lines(df_subset$DT, df_subset$Sub_metering_3, type = "l", col = "blue", lwd=1)
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, lwd=2, cex = 0.3)
mtext("Energy sub metering", side=2, line=2, cex = 0.8)
plot(df_subset$DT,df_subset$Global_reactive_power, type="l", col="black", lwd=1, xlab = "", ylab="", cex.lab = 0.6, cex.sub = 0.6, cex.axis = 0.8)
mtext("datetime", side=1, line=2, cex = 0.8)
mtext("Global_reactive_power", side=2, line=2, cex = 0.8)
dev.off()