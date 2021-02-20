#Reading csv
customer_data = read.csv("Mall_Customers.csv")

#Compactly display the internal structure of an R object
str(customer_data)

#Get or set the names of an object.
names(customer_data)

#printing the first 6 rows
head(customer_data)

#summary of data
summary(customer_data)

#standard deviation and summary of 
#age, annual income, spending score
sd(customer_data$Age, na.rm = TRUE)
summary(customer_data$Age)
sd(customer_data$Annual.Income..k.., na.rm = TRUE)
summary(customer_data$Annual.Income..k..)
sd(cutomer_data$Spending.Score..1.100.)
summary(customer_data$Spending.Score..1.100.)

#using bar graph to show gender distribution
gender_table = table(customer_data$Gender)
barplot(gender_table, main="Gender Comparison",ylab = "Count",
        xlab = "Gender", col = rainbow(2), legend = rownames(gender_table))
#if you get this error
#Error in plot.new() : figure margins too large, try
#par(mar=c(2,2,1,1))

#pie chart to show gender distribution
pct <- round(gender_table/sum(gender_table)*100)
lbs <- paste(c("Female", "Male")," ", pct, "%", sep = " ")
library(plotrix)
pie3D(gender_table, labels = lbs, main = "Gender Comparison")

#histogram to show frequency of customer ages
hist(customer_data$Age, col = "purple", main = "Age Distribution",
     xlab = "Age", ylab = "Frequency", labels = TRUE)

#box plot to show frequency of customer ages
boxplot(customer_data$Age, col = "pink", main = "Age Distribution")

#histogram to show annual income
hist(customer_data$Annual.Income..k.., col = "blue", main = "Annual Income",
     xlab = "Annual Income Class", ylab = "Frequency", labels = TRUE)

#density plot for annual income
plot(density(customer_data$Annual.Income..k..), col = "yellow", 
     main = "Annual Income: Density Plot", xlab = "Annual Income Class", 
     ylab = "Density")
polygon(density(customer_data$Annual.Income..k..),
        col="#ccff66")

#box plot- spending score
boxplot(customer_data$Spending.Score..1.100., horizontal=TRUE, col="#990000",
        main="Spending Score")

#histogram- spending score
hist(customer_data$Spending.Score..1.100., main="HistoGram for Spending Score",
     xlab="Spending Score Class", ylab="Frequency",
     col="#6600cc", labels=TRUE)

#ELBOW METHOD
library(purrr)
set.seed(123)

# function to calculate total intra-cluster sum of square 
iss <- function(k) {
    kmeans(customer_data[,3:5],k,iter.max=100,nstart=100,algorithm="Lloyd" )$tot.withinss
}
#giving k values 1 to 10
k.values <- 1:10

iss_values <- map_dbl(k.values, iss)

#plotting k values to find the elbow point
plot(k.values, iss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total intra-clusters sum of squares")

#AVERAGE SILHOUETTE METHOD
library(cluster)
library(gridExtra)
library(grid)

#k=2
k2 <- kmeans(customer_data[,3:5], 2, iter.max = 100, nstart = 50, 
             algorithm = "Lloyd")
s2 <- plot(silhouette(k2$cluster, dist(customer_data[,3:5], "euclidean")))

#k=3
k3<-kmeans(customer_data[,3:5],3,iter.max=100,nstart=50,algorithm="Lloyd")
s3<-plot(silhouette(k3$cluster,dist(customer_data[,3:5],"euclidean")))

#k=4
k4<-kmeans(customer_data[,3:5],4,iter.max=100,nstart=50,algorithm="Lloyd")
s4<-plot(silhouette(k4$cluster,dist(customer_data[,3:5],"euclidean")))

#k=5
k5<-kmeans(customer_data[,3:5],5,iter.max=100,nstart=50,algorithm="Lloyd")
s5<-plot(silhouette(k5$cluster,dist(customer_data[,3:5],"euclidean")))

#k=6
k6<-kmeans(customer_data[,3:5],6,iter.max=100,nstart=50,algorithm="Lloyd")
s6<-plot(silhouette(k6$cluster,dist(customer_data[,3:5],"euclidean")))

#k=7
k7<-kmeans(customer_data[,3:5],7,iter.max=100,nstart=50,algorithm="Lloyd")
s7<-plot(silhouette(k7$cluster,dist(customer_data[,3:5],"euclidean")))

#k=8
k8<-kmeans(customer_data[,3:5],8,iter.max=100,nstart=50,algorithm="Lloyd")
s8<-plot(silhouette(k8$cluster,dist(customer_data[,3:5],"euclidean")))

#k=9
k9<-kmeans(customer_data[,3:5],9,iter.max=100,nstart=50,algorithm="Lloyd")
s9<-plot(silhouette(k9$cluster,dist(customer_data[,3:5],"euclidean")))

#k=10
k10<-kmeans(customer_data[,3:5],10,iter.max=100,nstart=50,algorithm="Lloyd")
s10<-plot(silhouette(k10$cluster,dist(customer_data[,3:5],"euclidean")))

#to visualize the optimal number of clusters
library(NbClust)
library(factoextra)

fviz_nbclust(customer_data[,3:5], kmeans, method = "silhouette")

#GAP STATISTIC METHOD
#plot to get optimal number of clusters
set.seed(125)
stat_gap <- clusGap(customer_data[,3:5], FUN = kmeans, nstart = 25,
                    K.max = 10, B = 50)
fviz_gap_stat(stat_gap)

#k=6 as optimal cluster
k6<-kmeans(customer_data[,3:5],6,iter.max=100,nstart=50,algorithm="Lloyd")
k6

#Visualizing the Clustering Results using the First Two Principle Components
pcclust=prcomp(customer_data[,3:5],scale=FALSE) #principal component analysis
summary(pcclust)
pcclust$rotation[,1:2]

set.seed(1)
ggplot(customer_data, aes(x =Annual.Income..k.., y = Spending.Score..1.100.)) + 
    geom_point(stat = "identity", aes(color = as.factor(k6$cluster))) +
    scale_color_discrete(name=" ",
                         breaks=c("1", "2", "3", "4", "5","6"),
                         labels=c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5","Cluster 6")) +
    ggtitle("Segments of Mall Customers", subtitle = "Using K-means Clustering")

ggplot(customer_data, aes(x =Spending.Score..1.100., y =Age)) + 
    geom_point(stat = "identity", aes(color = as.factor(k6$cluster))) +
    scale_color_discrete(name=" ",
                         breaks=c("1", "2", "3", "4", "5","6"),
                         labels=c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5","Cluster 6")) +
    ggtitle("Segments of Mall Customers", subtitle = "Using K-means Clustering")

kCols=function(vec){cols=rainbow (length (unique (vec)))
return (cols[as.numeric(as.factor(vec))])}

digCluster<-k6$cluster; dignm<-as.character(digCluster); # K-means clusters

plot(pcclust$x[,1:2], col =kCols(digCluster),pch =19,xlab ="K-means",ylab="classes")
legend("bottomleft",unique(dignm),fill=unique(kCols(digCluster)))
