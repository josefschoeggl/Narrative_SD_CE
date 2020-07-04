# load libraries
library(bibliometrix)
library(factoextra)
library(FactoMineR)


# load data (optional) 
MCE <- readRDS("data/MCE.RDS")


#calculate and plot conceptual structure
CS <- conceptualStructure(MCE, field = "ID", method = "MCA", labelsize = 10, k.max = 20,
                          minDegree = 60, clust = 12) 

