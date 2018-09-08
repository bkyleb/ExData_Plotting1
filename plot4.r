#####STEP 1: DOWNLOAD AND UNZIP THE DATASET########

library(datasets)
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("exdata_data_household_power_consumption.zip")){
        download.file(fileUrl,destfile = "exdata_data_household_power_consumption.zip")
}
if (!file.exists("household_power_consumption")){
        unzip("exdata_data_household_power_consumption.zip")
}
        
####STEP 2: READ THE DATASET#######
df<-read.table("household_power_consumption.txt",sep=";", na.strings = "?", colClasses = "character")
colnames(df)=df[1,]
df=df[-1,]

####STEP 3: SELECT DATA BETWEEN DATE 2007-02-1 AND 2007-02-02######
df[,1]=as.Date(df[,1],format = "%d/%m/%Y")
new.data=subset(df,df[,1]==as.Date("2007-02-01")|df[,1]==as.Date("2007-02-02"))
new.data$Time<-strptime(paste(new.data[,1],new.data[,2]), format = "%Y-%m-%d %H:%M:%S")


#####STEP 4: MAKE FOUR PLOTS IN ONE PAGE######
dev.new(width = 480, height = 480, unit = "px")
par(mfrow=c(2,2))
plot(new.data$Time,new.data$Global_active_power,type = "n", xlab = "",ylab = "Global Active Power")
lines(new.data$Time,new.data$Global_active_power)

plot(new.data$Time,new.data$Voltage,type = "n", xlab = "datetime",ylab = "Voltage")
lines(new.data$Time,new.data$Voltage)

plot(new.data$Time,new.data$Sub_metering_1 ,type = "n", xlab = "",ylab = "Energy sub metering")
lines(new.data$Time,new.data$Sub_metering_1)
lines(new.data$Time,new.data$Sub_metering_2, col="red")
lines(new.data$Time,new.data$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), xpd = TRUE,bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(new.data$Time,new.data$Global_reactive_power,type = "n", xlab = "datetime",ylab = "Global_reactive_power")
lines(new.data$Time,new.data$Global_reactive_power)

dev.copy(png, file="plot4.png")
dev.off()