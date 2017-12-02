install.packages("maptools")
library(plyr)
library(ggplot2)
library(maptools)

#Load the flow data required - origin and destination points are needed.
input<-read.table("C:/Users/Alexander/Google Drive/Classes/Fall2017/GEOG6030/Ex8/data/wu03ew_v1.csv", sep=",", header=T)
#input<-read.table("C:/Users/ahohl/Google Drive/Classes/Fall2017/GEOG6030/Ex8/data/wu03ew_v1.csv", sep=",", header=T)

#We only need the first 3 columns of the above
input<- input[,1:3]
names(input)<- c("origin", "destination","total")



#The UK Census file above didn't have coordinates just area codes. Here is a lookup that provides those
centroids<- read.csv("C:/Users/Alexander/Google Drive/Classes/Fall2017/GEOG6030/Ex8/data/msoa_popweightedcentroids.csv")
#centroids<- read.csv("C:/Users/ahohl/Google Drive/Classes/Fall2017/GEOG6030/Ex8/data/msoa_popweightedcentroids.csv")

#Lots of joining to get the xy coordinates joined to the origin and then the destination points.
or.xy<- merge(input, centroids, by.x="origin", by.y="Code")
names(or.xy)<- c("origin", "destination", "trips", "o_name", "oX", "oY")

dest.xy<-  merge(or.xy, centroids, by.x="destination", by.y="Code")
names(dest.xy)<- c("origin", "destination", "trips", "o_name", "oX", "oY","d_name", "dX", "dY")


#Now for plotting with ggplot2.This first step removes the axes in the resulting plot.
xquiet<- scale_x_continuous("", breaks=NULL)
yquiet<-scale_y_continuous("", breaks=NULL)
quiet<-list(xquiet, yquiet)



#pdf("myplot.pdf")


#Let's build the plot. First we specify the dataframe we need, with a filter excluding flows of <10
myplot <- 
  
ggplot(dest.xy[which(dest.xy$trips>10),], aes(oX, oY))+
  #The next line tells ggplot that we wish to plot line segments. The "alpha=" is line transparency and used below 
geom_segment(aes(x=oX, y=oY,xend=dX, yend=dY, alpha=trips), col="white")+
  #Here is the magic bit that sets line transparency - essential to make the plot readable
scale_alpha_continuous(range = c(0.03, 0.3))+
  #Set black background, ditch axes and fix aspect ratio
theme(panel.background = element_rect(fill='black',colour='black'))+quiet+coord_equal()

dev.off()

#print(myplot)
#dev.off()