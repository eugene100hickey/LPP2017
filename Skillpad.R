#set directory, read in data
setwd("C:/Academic/Science1/LPP/2017")
sp = read.csv2("skillpad.csv", sep=",")

#select just important columns
sp = sp[,c(2, 3, 4, 7, 9, 11)]

#set up a new frame to count completed lessons
sp1 = filter(sp, Lesson.Completed =="YES")
sp1 = sp1[, c(3,5)]
sp1 = table(sp1)
sp1 = as.data.frame(sp1)
sp1 = filter(sp1, Lesson.Completed == "YES")
sp1 = sp1[order(sp1$Username),]

#put sp in wide format, replace Na with "NO", add on number of completed lessons
sp = dcast(sp, Firstname+Lastname+Username~Lesson, value.var="Lesson.Completed")
sp[is.na(sp)] = "NO"
sp = sp[order(sp$Username),]
sp = cbind(sp, sp1$Freq)

#reorder and rename columns
sp = sp[,c(1:3, 20, 4:19)]
colnames(sp)[4] = "Number Completed"

sp = sp[with(sp, order(Lastname, Firstname)),]

