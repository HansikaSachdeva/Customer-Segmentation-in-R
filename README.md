# Customer-Segmentation-in-R
Customer Segmentation using Machine Learning in R

Customer Segmentation is the process of division of customer base into several groups of individuals that share a similarity in different ways that are relevant to marketing such as gender, age, interests, and miscellaneous spending habits.

Using clustering techniques, companies can identify the several segments of customers allowing them to target the potential user base. In this machine learning project, K-means clustering is used, which is the essential algorithm for clustering an unlabeled dataset.

K-means Algorithm

While using the k-means clustering algorithm, the first step is to indicate the number of clusters (k) that we wish to produce in the final output. The algorithm starts by selecting k objects from dataset randomly that will serve as the initial centers for our clusters.
1. We specify the number of clusters that we need to create.
2. The algorithm selects k objects at random from the dataset. This object is the initial cluster or mean.
3. The closest centroid obtains the assignment of a new observation. We base this assignment on the Euclidean Distance between object and the centroid.
4. k clusters in the data points update the centroid through calculation of the new mean values present in all the data points of the cluster. The kth cluster’s centroid has a length of p that contains means of all variables for observations in the k-th cluster. We denote the number of variables with p.
5. Iterative minimization of the total within the sum of squares. Then through the iterative minimization of the total sum of the square, the assignment stop wavering when we achieve maximum iteration. The default value is 10 that the R software uses for the maximum iterations.

Methods used:
1. Elbow method
2. Silhouette method
3. Gap statistic
