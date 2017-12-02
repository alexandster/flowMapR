install.packages("maps")

library(maps)
faketrace<-read.table("C:/Users/Alexander/Google Drive/Classes/Fall2017/GEOG6030/Ex8/data/fakeLocations.csv", sep=",", header=T)

map(database="world", col="#cccccc")

map(database="county", region = "north carolina", col="#cccccc")


lines(faketrace$longitude, faketrace$latitude, col="#bb4cd4", lwd=2)

symbols(faketrace$longitude, faketrace$latitude, lwd=1, bg="#bb4cd4", fg="#ffffff", circles=rep(1, length(faketrace$longitude)), inches=0.05, add=TRUE)


map(database="county", col="#cccccc")
for (i in 2:length(faketrace$longitude)-1) {
  lngs <-
    c(faketrace$longitude[8], faketrace$longitude[i])
  lats <-
    c(faketrace$latitude[8], faketrace$latitude[i])
  lines(lngs, lats, col="#bb4cd4", lwd=2)}
  