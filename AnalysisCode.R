# Data Preparation

library(stringr)

df.house <- read.delim("data/AllHomes_2614.txt", header = TRUE, sep="\t", na.strings = "NA")





# remove non alpha numerics from street
df.house$Address <- str_trim(gsub("[0-9,/,*]", "", df.house$Address))

# Convert dates
df.house$Contract.Date <- as.Date(df.house$Contract.Date , "%d/%m/%Y")
df.house$Transaction.Date <- as.Date(df.house$Transaction.Date , "%d/%m/%Y")
df.house$Advertise.Date <- as.Date(df.house$Advertise.Date , "%d/%m/%Y")

# Add Street.Type and extract from Address
df.house$Street.Type <- "NA"
df.house$Street.Type[grep("Street",df.house$Address)] <- "Street"
df.house$Street.Type[grep("St",df.house$Address)] <- "Street"
df.house$Street.Type[grep("Close",df.house$Address)] <- "Close"
df.house$Street.Type[grep("Drive",df.house$Address)] <- "Drive"
df.house$Street.Type[grep("Place",df.house$Address)] <- "Place"
df.house$Street.Type[grep("Circuit",df.house$Address)] <- "Circuit"
df.house$Street.Type[grep("Cct",df.house$Address)] <- "Circuit"
df.house$Street.Type[grep("Pl",df.house$Address)] <- "Place"



# Add Street.Type and extract from Address
df.house$Street.Name <- "NA"

# Add Contract.Year and extract from Contract.Date
df.house$Contract.Year <- as.factor(format(df.house$Contract.Date, "%Y"))


##########################################
df.house <- read.csv("data/HousePricesHawker.csv", header = TRUE, na.strings = "NA")

df.house$Contract.Date <- as.Date(df.house$Contract.Date , "%d/%m/%Y")
df.house$Transaction.Date <- as.Date(df.house$Transaction.Date , "%d/%m/%Y")
df.house$Advertise.Date <- as.Date(df.house$Advertise.Date , "%d/%m/%Y")
df.house$Contract.Year <- as.factor(format(df.house$Contract.Date, "%Y"))

df.residential <- subset(df.house, grepl("*Residential*", df.house$Purpose, ignore.case = TRUE))


no.na.data <- na.omit(data[c(predictors, response)])
model <- lm(formula=as.formula(paste(paste(response,'~', sep=''),
                                     paste(predictors,collapse='+'), sep='')),
            no.na.data)
step(model)


one_model <- lm(Price ~ Bed.Num + Block.Size.m2 + Contract.Year, data = df.house, na.action = na.omit)
find.model <- step(one_model, direction = "both")


predict(mod, data.frame(train_x = c(1, 2, 3)))

predict(one_model, data.frame(Bed.Num = c(4), Garage.Num = c(2)))

boxplot(df.house$Price)
boxplot(Price ~ Bed.Num, data = df.house)

Price.lm <- lm(Price ~ Bed.Num, data = df.house)
abline(Price.lm)

coplot(Price ~ Bath.Num|Bed.Num, data=df.house)


boxplot(Price ~ Bath.Num, data = df.house)

boxplot(Price ~ Garage.Num, data = df.house)

boxplot(Price ~ Ensuite.Num, data = df.house)

boxplot(Price ~ Carport.Num, data = df.house)


