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


#####STEP 4: MAKE PLOTTING OF GLOBAL ACTIVE POWER AGAINST DATE/TIME######
plot(new.data$Time,new.data$Global_active_power,type = "n", xlab = "",ylab = "Global Active Power (kilowatts)")
lines(new.data$Time,new.data$Global_active_power)
dev.copy(png, file="plot2.png")
dev.off()