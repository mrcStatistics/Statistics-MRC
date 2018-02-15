
## This function will allow to get the distance between two points based on their GPS coordinates
convertGPSintoPhysicalDistance = function(long1, lat1, long2, lat2)  
{
  deltaLong=deltaLat=a=b=b2=c=d=var1=var2=kDistance=0
  p = pi/180
  deltaLong = (long2-long1)*p
  deltaLat = (lat2-lat1)*p
  a = sin(deltaLat/2.0)
  b = sin(deltaLong/2.0)
  b2 = b^2
  c = cos(lat1*p)
  d = cos(lat2*p)
  var1 = a^2 + c*d*b2
  var2 = 2*atan2(sqrt(var1), sqrt(1-var1))
  kDistance = 6370*var2
  return(kDistance)
}






##################################################################################################################################
########################### Main text
###############################################

## read the data
maitre = fread("/home/karim/Documents/Maitre/MaitreData.txt")

## get the GPS coordinates columns
gpsData = subset(maitre, select=c(7:10))

## create a vector for the output storage (distance im m and km)
kDistance = numeric(nrow(gpsData))

## call the function to get the physical distance for all the 421 entries
for(i in 1:nrow(gpsData))
  kDistance[i] = convertGPSintoPhysicalDistance(gpsData$long1[i], gpsData$lat1[i], gpsData$long2[i], gpsData$lat2[i]) 


dataOfInterest = cbind(as.numeric(maitre$Dist), maitre$Paired_gen, kDistance)
dataOfInterest = as.data.frame(dataOfInterest)
names(dataOfInterest) = c("geneticDistance", "Paired_type", "Physical_Distance")
write.table(dataOfInterest, "/home/karim/Documents/Maitre/dataOfInterest.txt", row.names = F, col.names = TRUE, quote = F, sep = "\t")

