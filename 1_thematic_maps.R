#Thematic mapping

# library
library(bibliometrix)

# readRDS (optional)
MCE <- readRDS("data/MCE.RDS")

# Timeslices -----------------------------------------------------------------

# timeslices 2000-2018 
MCE1 <- subset(MCE, PY < 2019)
years <- c(2012, 2015)
TMslice <- timeslice(MCE1, breaks = years) 

names(TMslice)
NROW(TMslice$`(2000,2012]`)  # 224 papers
NROW(TMslice$`(2012,2015]`)  # 227 papers
NROW(TMslice$`(2015,2018]`)  # 1723 papers


# timeslice 2019
i <- MCE$PY < 2019
subdf <- subset.data.frame(MCE, subset = i)
restdf <- subset.data.frame(MCE, subset = !i)
early <- subset.data.frame(MCE, subset = is.na(i)) #add early access papers in the 2019 dataset as they did not have 2019 in PY column yet
MCE2 <- rbind(restdf,early)

# Analysis -----------------------------------------------------------------
library(igraph)  # required for exporting the network files

# variables
mF <- 5  # minimum Frequency
n <- 1000  # number of terms to be included in the analysis

# timeslice 2000-2012
tmce1 <- thematicMap(TMslice$`(2000,2012]`, field ="DE", n = n, minfreq = mF, stemming = FALSE, repel = TRUE)
words0012 <- as.data.frame(tmce1$words)  # to check which words are in a cluster (OPTIONAL)
write_graph(tmce1$net$graph_pajek, file = "thematic_network_2000-2012.net", format = "pajek")
 
#timeslice 2013-2015
tmce2 <- thematicMap(TMslice$`(2012,2015]`, field ="DE", n = n, minfreq = mF, stemming = FALSE, repel = TRUE)
words1315 <- as.data.frame(tmce2$words)
write_graph(tmce2$net$graph_pajek, file = "thematic_network_2013-2015.net", format = "pajek")

# timeslice 2016-2018
tmce3 <- thematicMap(TMslice$`(2015,2018]`, field ="DE", n = n, minfreq = mF, stemming = FALSE, repel = TRUE)
words1618 <- as.data.frame(tmce3$words)
write_graph(tmce3$net$graph_pajek, file = "thematic_network_2016-2018.net", format = "pajek")

# timeslice 2019
tmce4 <- thematicMap(MCE2, field ="DE", n = n, minfreq = mF, stemming = FALSE, repel = TRUE)
words19 <- as.data.frame(tmce4$words)
write_graph(tmce4$net$graph_pajek, file = "thematic_network_2019.net", format = "pajek")


# Plots -----------------------------------------------------------------

# standard plots
# plot(tmce1$map)
# plot(tmce2$map)
# plot(tmce3$map)
# plot(tmce4$map)

# ggplot
library("ggplot2")
library("ggrepel")

# change labels if necessary by modifying tm$clusters

# tm1
tmce1$clusters[1,7] <- "Circular Economy (CE)"
tmce1$clusters[3,7] <- "China and Industrial Ecology"


# tm2
tmce2$clusters[3,7] <- "CE and sustainab*"
tmce2$clusters[1,7] <- "china and industrial symbiosis"
tmce2$clusters[2,7] <- "Life Cycle Assessment (LCA)"

# tm3
tmce3$clusters[6,7] <- "CE, sustainab*, LCA, waste mgmt."
tmce3$clusters[7,7] <- "cleaner production and CSR"
tmce3$clusters[15,7] <- "zero waste and SDGs"

# tm4
tmce4$clusters[1,7] <- "CE, sustainab*, recycling, LCA"
tmce4$clusters[14,7] <- "design"


#2000-2012 ----
# prepare values for plot 
tm <- tmce1
size <- 0.8
meandens = mean(tm$clusters$rdensity)
meancentr = mean(tm$clusters$rcentrality)
rangex = max(c(meancentr - min(tm$clusters$rcentrality), max(tm$clusters$rcentrality) - 
                 meancentr))
rangey = max(c(meandens - min(tm$clusters$rdensity), max(tm$clusters$rdensity) - 
                 meandens))
xlimits = c(meancentr - rangex, meancentr + rangex)
ylimits = c(meandens - rangey, meandens + rangey)

# plot tmce1 
library(ggplot2)
library(ggrepel)

#export pdf
pdf(file = "tmce1.pdf", width = 3.54331, height = 3.54331)

#ggplot
g = ggplot(tm$clusters, aes(x = tm$clusters$rcentrality, y = tm$clusters$rdensity, text = (tm$clusters$words))) + 
  geom_point(group = "NA", aes(size = log(as.numeric(tm$clusters$freq))), 
             shape = 20, col = adjustcolor(tm$clusters$color, alpha.f = 0.5))
g = g + geom_hline(yintercept = meandens, linetype = 2, size = 0.3, color = adjustcolor("black",alpha.f = 0.7)) + 
  geom_vline(xintercept = meancentr, linetype = 2, size = 0.3, color = adjustcolor("black", alpha.f = 0.7)) 
g = g + geom_label_repel(aes(group = "NA", label = ifelse(tm$clusters$freq > 1, unlist(tolower(tm$clusters$name)), "")), 
                         size = 1.2 * (1 + size), angle = 0,
                         label.size = 0.1) #changed
g = g +   theme_bw() +  #new
  theme(legend.position = "none") + 
  scale_radius(range = c(5 * size, 60 * size)) +
  labs(x = "Centrality", y = "Density") + 
  xlim(xlimits) + 
  ylim(ylimits) + 
  theme(axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.background = element_blank(), #new
        panel.grid = element_blank()) #new
g
dev.off() #stop pdf export


# 2013-2015 -----------------------------------------------------------------
#prepare values for plot 
tm <- tmce2
size <- 0.8
meandens = mean(tm$clusters$rdensity)
meancentr = mean(tm$clusters$rcentrality)
rangex = max(c(meancentr - min(tm$clusters$rcentrality), max(tm$clusters$rcentrality) - 
                 meancentr))
rangey = max(c(meandens - min(tm$clusters$rdensity), max(tm$clusters$rdensity) - 
                 meandens))
xlimits = c(meancentr - rangex, meancentr + rangex)
ylimits = c(meandens - rangey, meandens + rangey)

# plot tmce1 

#export pdf
pdf(file = "tmce2.pdf", width = 3.54331, height = 3.54331)

#ggplot
g = ggplot(tm$clusters, aes(x = tm$clusters$rcentrality, y = tm$clusters$rdensity, text = (tm$clusters$words))) + 
  geom_point(group = "NA", aes(size = log(as.numeric(tm$clusters$freq))), 
             shape = 20, col = adjustcolor(tm$clusters$color, alpha.f = 0.5))

g = g + geom_hline(yintercept = meandens, linetype = 2, size = 0.3, color = adjustcolor("black",alpha.f = 0.7)) + 
  geom_vline(xintercept = meancentr, linetype = 2, size = 0.3, color = adjustcolor("black", alpha.f = 0.7)) 

g = g + geom_label_repel(aes(group = "NA", label = ifelse(tm$clusters$freq > 1, unlist(tolower(tm$clusters$name)), "")), 
                         size = 1.2 * (1 + size), angle = 0,
                         label.size = 0.1) #changed

g = g +   theme_bw() +  #new
  theme(legend.position = "none") + 
  scale_radius(range = c(5 * size, 60 * size)) +
  labs(x = "Centrality", y = "Density") + 
  xlim(xlimits) + 
  ylim(ylimits) + 
  theme(axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.background = element_blank(), #new
        panel.grid = element_blank()) #new
g
dev.off() #stop pdf export


# 2016-2018 -----------------------------------------------------------------
#prepare values for plot 
tm <- tmce3
size <- 0.8
meandens = mean(tm$clusters$rdensity)
meancentr = mean(tm$clusters$rcentrality)
rangex = max(c(meancentr - min(tm$clusters$rcentrality), max(tm$clusters$rcentrality) - 
                 meancentr))
rangey = max(c(meandens - min(tm$clusters$rdensity), max(tm$clusters$rdensity) - 
                 meandens))
xlimits = c(meancentr - rangex, meancentr + rangex)
ylimits = c(meandens - rangey, meandens + rangey)

# plot tmce1 

#export pdf
pdf(file = "tmce3.pdf", width = 3.54331, height = 3.54331)

#ggplot
g = ggplot(tm$clusters, aes(x = tm$clusters$rcentrality, y = tm$clusters$rdensity, text = (tm$clusters$words))) + 
  geom_point(group = "NA", aes(size = log(as.numeric(tm$clusters$freq))), 
             shape = 20, col = adjustcolor(tm$clusters$color, alpha.f = 0.5))

g = g + geom_hline(yintercept = meandens, linetype = 2, size = 0.3, color = adjustcolor("black",alpha.f = 0.7)) + 
  geom_vline(xintercept = meancentr, linetype = 2, size = 0.3, color = adjustcolor("black", alpha.f = 0.7)) 


g = g +   theme_bw() +  #new
  theme(legend.position = "none") + 
  scale_radius(range = c(5 * size, 60 * size)) +
  labs(x = "Centrality", y = "Density") + 
  xlim(xlimits) + 
  ylim(ylimits) + 
  theme(axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.background = element_blank(), # new
        panel.grid = element_blank()) # new

g = g + geom_label_repel(aes(group = "NA", label = ifelse(tm$clusters$freq > 1, unlist(tolower(tm$clusters$name)), "")), 
                         size = 1.2 * (1 + size), angle = 0,
                         label.size = 0.1,  # new
                         force = 2)  # changed


g
dev.off() #stop pdf export


# 2019 -----------------------------------------------------------------
#prepare values for plot 
tm <- tmce4
size <- 0.8
meandens = mean(tm$clusters$rdensity)
meancentr = mean(tm$clusters$rcentrality)
rangex = max(c(meancentr - min(tm$clusters$rcentrality), max(tm$clusters$rcentrality) - 
                 meancentr))
rangey = max(c(meandens - min(tm$clusters$rdensity), max(tm$clusters$rdensity) - 
                 meandens))
xlimits = c(meancentr - rangex, meancentr + rangex)
ylimits = c(meandens - rangey, meandens + rangey)

# plot tmce4

#export pdf
pdf(file = "tmce4.pdf", width = 3.54331, height = 3.54331)

#ggplot
g = ggplot(tm$clusters, aes(x = tm$clusters$rcentrality, y = tm$clusters$rdensity, text = (tm$clusters$words))) + 
  geom_point(group = "NA", aes(size = log(as.numeric(tm$clusters$freq))), 
             shape = 20, col = adjustcolor(tm$clusters$color, alpha.f = 0.5))

g = g + geom_hline(yintercept = meandens, linetype = 2, size = 0.3, color = adjustcolor("black",alpha.f = 0.7)) + 
  geom_vline(xintercept = meancentr, linetype = 2, size = 0.3, color = adjustcolor("black", alpha.f = 0.7)) 


g = g +   theme_bw() +  #new
  theme(legend.position = "none") + 
  scale_radius(range = c(5 * size, 60 * size)) +
  labs(x = "Centrality", y = "Density") + 
  xlim(xlimits) + 
  ylim(ylimits) + 
  theme(axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        plot.background = element_blank(), #new
        panel.grid = element_blank()) #new

g = g + geom_label_repel(aes(group = "NA", label = ifelse(tm$clusters$freq > 1, unlist(tolower(tm$clusters$name)), "")), 
                         size = 1.2 * (1 + size), angle = 0,
                         label.size = 0.1,  # changed
                         force = 3 )  # changed

g
dev.off() #stop pdf export
