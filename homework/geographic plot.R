
install.packages("chron")


#�ȸ���ͼ
contour(x=10*1:nrow(volcano), 
        y=10*1:ncol(volcano), z=volcano,
        xlab="Metres West",ylab="Metres North",
        main="Topography of Maunga Whau Volcano")

u<-par("usr")
rect(u[1],u[3],u[2],u[4],col="lightgreen ")
contour(x=10*1:nrow(volcano),y=10*1:ncol(volcano),
        volcano,col="red",add=TRUE)


# ��ͼ
install.packages("maps")
library(maps)

map("state", region=c("california","virginia"))
map("county","new york")
library(RColorBrewer)
map('italy', fill = TRUE, col = brewer.pal(7,"Set1"))

#������������ͼ

x<-map("state",plot=FALSE)
class(x)

for(i in 1:length(rownames(USArrests))) {
  for(j in 1:length(x$names)) {
    if( grepl ( rownames(USArrests)[i], x$names[j], ignore.case=T)) 
      x$measure[j]<-as.double(USArrests$Murder[i]) #��murder�����ᵽmap��x�����measure��
  }
}
colors <- brewer.pal(7,"Reds")
sd <- data.frame(col=colors, #��ֵ���࣬˳���Ӧ��ɫ
     values=seq(min(x$measure[!is.na(x$measure)]),
                max(x$measure[!is.na(x$measure)])*1.0001, #ȡ1.0001��Ϊ�Ǵ��ڵ���
                length.out=7))

breaks<-sd$values
matchcol<-function(y) {  #������y��ƥ�����ɫֵ��ע��findInterval����
  as.character(sd$col[findInterval(y,sd$values)])
}

layout(matrix(data=c(2,1), nrow=1, ncol=2), widths=c(8,1), heights=c(8,1))

# Color Scale first
par(mar = c(20,1,20,7),oma=c(0.2,0.2,0.2,0.2),mex=0.5)
image(x=1, y=0:length(breaks),z=t(matrix(breaks))*1.001,
      col=colors[1:length(breaks)-1],axes=FALSE,breaks=breaks,
      xlab="", ylab="", xaxt="n") #���ﻭͼ��Ҫ���ĺܴ���򻭲�����
axis(4,at=0:(length(breaks)-1),
     labels=round(breaks),col="white",las=1)
abline(h=c(1:length(breaks)),col="white",lwd=2,xpd=F)
#Map
map("state", boundary = FALSE,col=matchcol(x$measure),
    fill=TRUE,lty="blank")
map("state", col="white",add = TRUE)
title("Murder Rates by US State in 1973 \n
(arrests per 100,000 residents)", line=2)



#sp���������Ľ�����
install.packages("sp")
library(sp)
load(url("http://gadm.org/data/rda/FRA_adm1.RData"))
gadm$rainfall<-rnorm(length(gadm$NAME_1),mean=50,sd=15)
spplot(gadm,"rainfall",
       col.regions = 
         rev(terrain.colors(gadm$rainfall)),
       main="Rainfall (simulated) in French 
       administrative regions")



#�ȸ��ͼ
install.packages("rgdal") 
library(rgdal)
install.packages("RgoogleMaps")  # google maps api for r
library(RgoogleMaps)

#air<-read.csv("londonair.csv")
air <- londonair # "site_code" "site_name" "PM10"      "lat"       "long"      "color"    
london<-GetMap(center=c(51.51,-0.116),
               zoom =10, destfile = "London.png",maptype  = "mobile")
str(london)
PlotOnStaticMap(london,lat = air$lat, lon = air$lon,
                cex=2,pch=19,col=as.character(air$color)) 
#���׶ص�ͼgooglemapΪ�ײ㣬���վ�γ�Ȱ����ݵ��ע��ȥ

#satellite
london<-GetMap(center=c(51.51,-0.116),zoom =13, destfile = "London_satellite.png",
               maptype = "satellite")
PlotOnStaticMap(london,lat = air$lat, lon = air$lon,
                cex=2,pch=19,col=as.character(air$color)) #����zoom=13��������ͼ������û������

#output
GetMap(center=c(40.714728,-73.99867), zoom =14, 
       destfile = "Manhattan.png", 
       maptype = "hybrid"); 

#�߾���
GetMap.OSM(lonR= c(-74.67102, -74.63943),
           latR = c(40.33804,40.3556),scale = 7500,
           destfile = "PrincetonOSM.png")
