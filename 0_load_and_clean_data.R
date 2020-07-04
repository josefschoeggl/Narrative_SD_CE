# Load CE pt1 -----------------------------------------------------------------------------------
# this is the first part of full data set used in section 4.1-4.3

# Document details:

# Scopus 
# Results: 1946
# TITLE-ABS-KEY ( "circular econom*")  AND  DOCTYPE ( ar  OR  re )  AND  PUBYEAR  <  2019

# Web of Knowledge
# Results: 1660
# (from Web of Science Core Collection)
# You searched for: TOPIC: ("circular econom*")
# Refined by: [excluding] PUBLICATION YEARS: ( 2019 ) AND DOCUMENT TYPES: ( ARTICLE OR REVIEW )
# Timespan: All years. Indexes: SCI-EXPANDED, SSCI, A&HCI, CPCI-S, CPCI-SSH, ESCI.

# library
# install.packages("bibliometrix)
library(bibliometrix)  # version 2.2.1 was used for the analysis in this paper

# Read files
D1 <- readFiles("data/CE/scopusCE1.bib")
D2 <- readFiles("data/CE/wosCE1.bib")
D3 <- readFiles("data/CE/wosCE2.bib")
D4 <- readFiles("data/CE/wosCE3.bib")
D5 <- readFiles("data/CE/wosCE4.bib")

# Convert files to bibliographic dataframes
M1 <- convert2df(D1, dbsource = "scopus", format = "bibtex")  #1946 extracted
M2 <- convert2df(D2, dbsource = "isi", format = "bibtex")  # 500 extracted
M3 <- convert2df(D3, dbsource = "isi", format = "bibtex")  # 500 extracted
M4 <- convert2df(D4, dbsource = "isi", format = "bibtex")  # 500 extracted
M5 <- convert2df(D5, dbsource = "isi", format = "bibtex")  # 161 extracted

# Merge dataframes
M <- mergeDbSources(M1,M2,M3,M4,M5, remove.duplicated = TRUE)  # 1347 duplicated documents removed, 2260 documents remaining

# Metatagextraction
M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
M <- metaTagExtraction(M, Field = "CR_AU", sep = ";")
M <- metaTagExtraction(M, Field = "CR_SO", sep = ";")
M <- metaTagExtraction(M, Field = "AU1_CO", sep = ";")
M <- metaTagExtraction(M, Field = "AU_UN", sep = ";")
M <- metaTagExtraction(M, Field = "SR", sep = ";")

# use duplicatedMatching
M_removeduplicatesDI <- duplicatedMatching(M, Field = "DI", tol = 0.97)  # 2187 papers remaining

# manually remove additional duplicated articles
MCE <- subset(M_removeduplicatesDI, SR != "BIANCO L, 2016, METALL ITAL-a")
MCE <- subset(MCE, SR != "BRACONI A, 2016, METALL ITAL-a")
MCE <- subset(MCE, SR != "CRISTIANI P, 2017, METALL ITAL-a")
MCE <- subset(MCE, SR != "FU J F, 2012, PROG CHEM")
MCE <- subset(MCE, SR != "IEVDOKYMOV V, 2018, EKONOMISTA")
MCE <- subset(MCE, SR != "JACQUET N, 2015, BIOTECHNOL AGRON SOC ENVIRON")
MCE <- subset(MCE, SR != "KARAYANNIS V, 2016, REV ROM MATER ROM J MATER")
MCE <- subset(MCE, SR != "LANDRA G, 2016, METALL ITAL-a")
MCE <- subset(MCE, SR != "MARLET C, 2014, ZKG INT-a")
MCE <- subset(MCE, SR != "PICHLAK M, 2018, EKONOMISTA")
MCE <- subset(MCE, SR != "RODRIGUEZ A, 2016, REV OBRAS PUBLICAS")
MCE <- subset(MCE, SR != "ROHAN M, 2016, REV ROM MATER ROM J MATER")
MCE <- subset(MCE, SR != "WEI F, 2014, J GREY SYST-a")  # 2174 papers remaining

# Save as distinct dataframe CHECK
MCE1 <- MCE
# saveRDS(MCE_unmodified, file = "MCE_unmodified.RDS")  # OPTIONAL

# Load CE pt2 -----------------------------------------------------------------------------------
# this is the second part of full data set used in section 4.1-4.3

# Scopus
# Results: 1403
# TITLE-ABS-KEY ( "circular econom*")  AND  DOCTYPE ( ar  OR  re )  AND  PUBYEAR  =  2019

# Web of Knowledge
# Results: 1369
# (from Web of Science Core Collection)
# You searched for: TOPIC: ("circular econom*")
# You searched for: TOPIC: ("circular econom*")
# Refined by: PUBLICATION YEARS: ( 2019 ) AND DOCUMENT TYPES: ( ARTICLE OR REVIEW )
# Timespan: All years. Indexes: SCI-EXPANDED, SSCI, A&HCI, ESCI.

# read files
D1 <- readFiles("data/CE/scopusCE2.bib")
D2 <- readFiles("data/CE/wosCE5.bib")
D3 <- readFiles("data/CE/wosCE6.bib")
D4 <- readFiles("data/CE/wosCE7.bib")

# convert files to bibliographic dataframes
M1 <- convert2df(D1, dbsource = "scopus", format = "bibtex")  # 1946 extracted
M2 <- convert2df(D2, dbsource = "isi", format = "bibtex")  # 500 extracted
M3 <- convert2df(D3, dbsource = "isi", format = "bibtex")  # 500 extracted
M4 <- convert2df(D4, dbsource = "isi", format = "bibtex")  # 396 extracted

# Merge dataframes
M <- mergeDbSources(M1,M2,M3,M4, remove.duplicated = TRUE)  # 1109 duplicated documents removed
# 1690 documents

# Metatagextraction
M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
M <- metaTagExtraction(M, Field = "CR_AU", sep = ";")
M <- metaTagExtraction(M, Field = "CR_SO", sep = ";") 
M <- metaTagExtraction(M, Field = "AU1_CO", sep = ";")
M <- metaTagExtraction(M, Field = "AU_UN", sep = ";")
M <- metaTagExtraction(M, Field = "SR", sep = ";")

# duplicatedMatching
M <- duplicatedMatching(M, Field = "DI", tol = 0.95)  # 1648 remaining

# save as distinct dataframe
MCE2 <- M

# Merge CE -----------------------------------------------------------------------------------
MCE1 = subset(MCE1, select = -c(PA))
MCE_unmod <- rbind(MCE1,MCE2)
MCE <- MCE_unmod  # 3822

# save RDS (optional)
# saveRDS(MCE, file = "MCE_unmod.RDS")  # OPTIONAL

# Load CESUS -----------------------------------------------------------------------------------
# this is the subset that is used in section 4.4 and section 4.5 literature on CE and sustainability

#Document details:

#Scopus 
#Results: 1651
#TITLE-ABS-KEY ( "circular econom*"  AND  "sustainab*" )  AND  DOCTYPE ( ar  OR  re )  AND  PUBYEAR  <  2020

#Web of Knowledge
#Results: 1799
#(from Web of Science Core Collection)
#You searched for: TOPIC: (circular econom*) AND TOPIC: (sustainab*) NOT YEAR PUBLISHED: (2020) 
#AND DOCUMENT TYPES: (Article OR Review) 

# load files
D1 <- readFiles("data/CESUS/scopusCESUS.bib")
D2 <- readFiles("data/CESUS/wosCESUS1.bib")
D3 <- readFiles("data/CESUS/wosCESUS2.bib")
D4 <- readFiles("data/CESUS/wosCESUS3.bib")
D5 <- readFiles("data/CESUS/wosCESUS4.bib")


# Conversion
M1 <- convert2df(D1, dbsource = "scopus", format = "bibtex")  # 1651 extracted
M2 <- convert2df(D2, dbsource = "isi", format = "bibtex")  # 500 extracted
M3 <- convert2df(D3, dbsource = "isi", format = "bibtex")  # 500 extracted
M4 <- convert2df(D4, dbsource = "isi", format = "bibtex")  # 500 extracted
M5 <- convert2df(D5, dbsource = "isi", format = "bibtex")  # 299 extracted

M <- mergeDbSources(M1,M2,M3,M4,M5, remove.duplicated = TRUE)

# Metatagextraction
M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
M <- metaTagExtraction(M, Field = "CR_AU", sep = ";")
M <- metaTagExtraction(M, Field = "CR_SO", sep = ";")
M <- metaTagExtraction(M, Field = "AU1_CO", sep = ";")
M <- metaTagExtraction(M, Field = "AU_UN", sep = ";")
M <- metaTagExtraction(M, Field = "SR", sep = ";")

# manually remove duplicated articles
M <- duplicatedMatching(M, Field = "DI", tol = 0.97) #2153 remaining
MCESUS <- M

# save as RDS (optional)
# saveRDS(MCESUS, "MCESUS_unmod.RDS")  # OPTIONAL


# Clean data -----------------------------------------------------------------------------------
# 5 subsections for cleaning the Data
# CE ID = Keywords Plus in the full dataset
# CE DE = Author Keywords in full dataset
# CE AB = Abstracts for the correlated topic modelling in the full dataset
# CESUS ID = Keywords Plus in CE-SD subset
# CESUS DE = Author Keywords in CE-SD subset


# CE "ID" -----------------------------------------------------

# replace Keywords plus
n <- MCE
n$ID <- gsub("PRIORITY JOURNAL","",n$ID)
n$ID <- gsub("\\(|\\)","",n$ID) # first remove brackets from keywords (which are otherwise not recognized)
n$ID <- gsub("LIFE CYCLE ASSESSMENT LCA|LIFE CYCLE ANALYSIS|LIFE-CYCLE ASSESSMENT","LIFE CYCLE ASSESSMENT",n$ID)
n$ID <- gsub("LCA","LIFE CYCLE ASSESSMENT",n$ID)
n$ID <- gsub("SUSTAINABILITY|SUSTAINABLE DEVELOPMENT","SUSTAINAB*",n$ID)
n$ID <- gsub("BUSINESS MODELS","BMS*",n$ID)
n$ID <- gsub("WASTE WATER","WASTEWATER",n$ID)
n$ID <- gsub("WASTES","WASTE",n$ID)
n$ID <- gsub("BIOFUELS","BIOFUEL",n$ID)
n$ID <- gsub("MODELS","MODEL",n$ID)
n$ID <- gsub("HUMANS","HUMAN",n$ID)
n$ID <- gsub("REVIEWS","REVIEW",n$ID)
n$ID <- gsub("SYSTEMS","SYSTEM",n$ID)
n$ID <- gsub("MANUFACTURE","MANUFACTURING",n$ID)
n$ID <- gsub("ECO-DESIGNS","ECODESIGN",n$ID)
n$ID <- gsub("INDUSTRIES","INDUSTRY",n$ID)
n$ID <- gsub("EFFICIENCIES","EFFICIENCY",n$ID)
n$ID <- gsub("CHAINS","CHAIN",n$ID)
n$ID <- gsub("DEVELOPING-COUNTRIES|DEVELOPING COUNTRIES","DEVELOPING COUNTRY",n$ID)
n$ID <- gsub("RESOURCES","RESOURCE",n$ID)
n$ID <- gsub("BUILDINGS","BUILDING",n$ID)
n$ID <- gsub("MATERIALS","MATERIAL",n$ID)
n$ID <- gsub("ENVIRONMENTAL IMPACTS","ENVIRONMENTAL IMPACT",n$ID)
n$ID <- gsub("FERTILIZERS","FERTILIZER",n$ID)
n$ID <- gsub("LAND FILL","LANDFILL",n$ID)
n$ID <- gsub("GREENHOUSE GASES","GREENHOUSE GAS",n$ID)
n$ID <- gsub("INVESTMENTS","INVESTMENT",n$ID)
n$ID <- gsub("CHALLENGES","CHALLENGE",n$ID)
n$ID <- gsub("TECHNOLOGIES","TECHNOLOGY",n$ID)
n$ID <- gsub("ECONOMIC ACTIVITIES","ECONOMIC ACTIVITY",n$ID)
n$ID <- gsub("PLASTICS","PLASTIC",n$ID)
n$ID <- gsub("PRODUCT-SERVICE SYSTEMS","PRODUCT SERVICE SYSTEM",n$ID)
n$ID <- gsub("BIOREFINERIES","BIOREFINERY",n$ID)
n$ID <- gsub("METALS","METAL",n$ID)
n$ID <- gsub("NATURAL RESOURCES","NATURAL RESOURCE",n$ID)
n$ID <- gsub("ECOSYSTEMS","ECOSYSTEM",n$ID)
n$ID <- gsub("NUTRIENTS","NUTRIENT",n$ID)
n$ID <- gsub("EFFLUENTS","EFFLUENT",n$ID)
n$ID <- gsub("FOSSIL FUELS","FOSSIL FUEL",n$ID)
n$ID <- gsub("ANIMALS","ANIMAL",n$ID)
n$ID <- gsub("BYPRODUCTS","BYPRODUCT",n$ID)
n$ID <- gsub("CITIES","CITY",n$ID)
n$ID <- gsub("COSTS","COST",n$ID)
n$ID <- gsub("ECONOMIES","ECONOMY",n$ID)
n$ID <- gsub("RENEWABLE ENERGIES","RENEWABLE ENERGY",n$ID)
n$ID <- gsub("BUILDINGS","BUILDING",n$ID)
n$ID <- gsub("CEMENTS","CEMENT",n$ID)
n$ID <- gsub("ECOSYSTEM SERVICES","ECOSYSTEM SERVICE",n$ID)
n$ID <- gsub("ENZYMES","ENZYME",n$ID)
n$ID <- gsub("INDUSTRIAL EMISSIONS","INDUSTRIAL EMISSION",n$ID)
n$ID <- gsub("TEXTILES","TEXTILE",n$ID)
n$ID <- gsub("PARKS","PARK",n$ID)
n$ID <- gsub("STRATEGIES","STRATEGY",n$ID)
n$ID <- gsub("WASTE DISPOSAL FACILITIES","WASTE DISPOSAL FACILITY",n$ID)
n$ID <- gsub("MANURES","MANURE",n$ID)

#replace keywords, that otherwise would be erased (don't forget to re-replace afterwards)
n$ID <- gsub("ECONOMIC ANALYSIS","ECONOMIC ANALYSATION",n$ID)
n$ID <- gsub("MATERIAL FLOW ANALYSIS","MATERIAL FLOW ANALYSATION",n$ID)
n$ID <- gsub("COST BENEFIT ANALYSIS|COST-BENEFIT ANALYSIS","COST BENEFIT ANALYSATION",n$ID)

n2 <- n
n2$ID <- gsub("CHINA|ARTICLE|PRIORITY JOURNAL|HUMAN|EUROPEAN UNION|PROCEDURES|OPTIMIZATION|SPAIN|CONCEPTUAL FRAMEWORK|REVIEW|EUROPE|
             |INDUSTRIAL RESEARCH|NONHUMAN|NETHERLANDS|MODEL|COMPARATIVE STUDY|CONTROLLED STUDY|UNITED KINGDOM|FRAMEWORK|
              |EVOLUTION|STRATEGIC APPROACH|SURVEYS|INTEGRATED APPROACH|FEASIBILITY STUDY|ITALY|QUANTITATIVE ANALYSIS|ASIA|
              |NUMERICAL MODEL|PERSPECTIVE|RESEARCH WORK|THEORETICAL STUDY|ANALYSIS|BELGIUM|CHEMICAL ANALYSIS|METHODOLOGY|
              |SENSITIVITY ANALYSIS|LITERATURE REVIEW|UNCLASSIFIED DRUG","",n2$ID) #delete keywords

#re-replacement of keywords, that should not be affected by erasing process
n3 <- n2
n3$ID <- gsub("ECONOMIC ANALYSATION","ECONOMIC ANALYSIS",n3$ID)
n3$ID <- gsub("MATERIAL FLOW ANALYSATION","MATERIAL FLOW ANALYSIS",n3$ID)
n3$ID <- gsub("COST BENEFIT ANALYSATION","COST BENEFIT ANALYSIS",n3$ID)
MCE <-n3 



# CE "DE" -----------------------------------------------------------------------------------

# replace Author keywords
n <- MCE
n$DE <- gsub("PRIORITY JOURNAL","",n$DE)
n$DE <- gsub("\\(|\\)","",n$DE) # first remove brackets from keywords (which are otherwise not recognized)
n$DE <- gsub("LIFE CYCLE ASSESSMENT LCA|LIFE CYCLE ANALYSIS|LIFE-CYCLE ASSESSMENT","LIFE CYCLE ASSESSMENT",n$DE)
n$DE <- gsub("circular economy ce", "CIRCULAR ECONOMY",n$DE) # use | (= logical OR) between different keywords
n$DE <- gsub("LCA","LIFE CYCLE ASSESSMENT",n$DE)
n$DE <- gsub("SUSTAINABILITY|SUSTAINABLE DEVELOPMENT","SUSTAINAB*",n$DE)
n$DE <- gsub("BUSINESS MODELS","BMS*",n$DE)
n$DE <- gsub("WASTE WATER","WASTEWATER",n$DE)
n$DE <- gsub("WASTES","WASTE",n$DE)
n$DE <- gsub("BIOFUELS","BIOFUEL",n$DE)
n$DE <- gsub("MODELS","MODEL",n$DE)
n$DE <- gsub("HUMANS","HUMAN",n$DE)
n$DE <- gsub("REVIEWS","REVIEW",n$DE)
n$DE <- gsub("SYSTEMS","SYSTEM",n$DE)
n$DE <- gsub("MANUFACTURE","MANUFACTURING",n$DE)
n$DE <- gsub("ECO-DESIGNS","ECODESIGN",n$DE)
n$DE <- gsub("INDUSTRIES","INDUSTRY",n$DE)
n$DE <- gsub("EFFICIENCIES","EFFICIENCY",n$DE)
n$DE <- gsub("CHAINS","CHAIN",n$DE)
n$DE <- gsub("DEVELOPING-COUNTRIES|DEVELOPING COUNTRIES","DEVELOPING COUNTRY",n$DE)
n$DE <- gsub("RESOURCES","RESOURCE",n$DE)
n$DE <- gsub("BUILDINGS","BUILDING",n$DE)
n$DE <- gsub("MATERIALS","MATERIAL",n$DE)
n$DE <- gsub("ENVIRONMENTAL IMPACTS","ENVIRONMENTAL IMPACT",n$DE)
n$DE <- gsub("FERTILIZERS","FERTILIZER",n$DE)
n$DE <- gsub("LAND FILL","LANDFILL",n$DE)
n$DE <- gsub("GREENHOUSE GASES","GREENHOUSE GAS",n$DE)
n$DE <- gsub("INVESTMENTS","INVESTMENT",n$DE)
n$DE <- gsub("CHALLENGES","CHALLENGE",n$DE)
n$DE <- gsub("TECHNOLOGIES","TECHNOLOGY",n$DE)
n$DE <- gsub("ECONOMIC ACTIVITIES","ECONOMIC ACTIVITY",n$DE)
n$DE <- gsub("PLASTICS","PLASTIC",n$DE)
n$DE <- gsub("PRODUCT-SERVICE SYSTEMS","PRODUCT SERVICE SYSTEM",n$DE)
n$DE <- gsub("BIOREFINERIES","BIOREFINERY",n$DE)
n$DE <- gsub("METALS","METAL",n$DE)
n$DE <- gsub("NATURAL RESOURCES","NATURAL RESOURCE",n$DE)
n$DE <- gsub("ECOSYSTEMS","ECOSYSTEM",n$DE)
n$DE <- gsub("NUTRIENTS","NUTRIENT",n$DE)
n$DE <- gsub("EFFLUENTS","EFFLUENT",n$DE)
n$DE <- gsub("FOSSIL FUELS","FOSSIL FUEL",n$DE)
n$DE <- gsub("ANIMALS","ANIMAL",n$DE)
n$DE <- gsub("BYPRODUCTS","BYPRODUCT",n$DE)
n$DE <- gsub("CITIES","CITY",n$DE)
n$DE <- gsub("COSTS","COST",n$DE)
n$DE <- gsub("ECONOMIES","ECONOMY",n$DE)
n$DE <- gsub("RENEWABLE ENERGIES","RENEWABLE ENERGY",n$DE)
n$DE <- gsub("BUILDINGS","BUILDING",n$DE)
n$DE <- gsub("CEMENTS","CEMENT",n$DE)
n$DE <- gsub("ECOSYSTEM SERVICES","ECOSYSTEM SERVICE",n$DE)
n$DE <- gsub("ENZYMES","ENZYME",n$DE)
n$DE <- gsub("INDUSTRIAL EMISSIONS","INDUSTRIAL EMISSION",n$DE)
n$DE <- gsub("TEXTILES","TEXTILE",n$DE)
n$DE <- gsub("PARKS","PARK",n$DE)
n$DE <- gsub("STRATEGIES","STRATEGY",n$DE)
n$DE <- gsub("WASTE DISPOSAL FACILITIES","WASTE DISPOSAL FACILITY",n$DE)
n$DE <- gsub("MANURES","MANURE",n$DE)

#different to the ID replacement
grep("CIRyCULAR ECONOMY", n$ID)
n$DE <- gsub("CIRCULAR ECONOMY (CE)","CIRCULAR ECONOMY",n$DE) #different from above 

#replace keywords, that otherwise would be erased (don't forget to re-replace afterwards)
n$DE <- gsub("ECONOMIC ANALYSIS","ECONOMIC ANALYSATION",n$DE)
n$DE <- gsub("MATERIAL FLOW ANALYSIS|MATERIAL FLOW ANALYIS (MFA)","MATERIAL FLOW ANALYSATION",n$DE)
n$DE <- gsub("COST BENEFIT ANALYSIS|COST-BENEFIT ANALYSIS","COST BENEFIT ANALYSATION",n$DE)

#re-replacement of keywords, that should not be affected by erasing process
n3 <- n
n3$DE <- gsub("ECONOMIC ANALYSATION","ECONOMIC ANALYSIS",n3$DE)
n3$DE <- gsub("MATERIAL FLOW ANALYSATION|MATERIAL FLOW ANALYSATION (MFA)", "MATERIAL FLOW ANALYSIS", n3$DE)
n3$DE <- gsub("COST BENEFIT ANALYSATION","COST BENEFIT ANALYSIS",n3$DE)
MCE <- n3


# CE "AB -----------------------------------------------------------------------------------
# clean Abstracts for the Correlated Topic Model
n <- MCE

# replace keywords
n$AB <- gsub("\\(|\\)","",n$AB)  # first remove brackets from keywords (which are otherwise not recognized)
n$AB <- gsub("CIRCULAR ECONOMY","CE",n$AB)  # CE maybe problematic
n$AB <- gsub("LIFE CYCLE ASSESSMENT LCA|LIFE CYCLE ANALYSIS|LIFE-CYCLE ASSESSMENT","LCA",n$AB)
n$AB <- gsub("LCA","LCA",n$AB)
MCE <- n



#CESUS "ID" -----------------------------------------------------------------------------------
# delete unwanted IDs in m (false keywords) 

#replace keywords
m <- MCESUS 
m$ID <- gsub("PRIORITY JOURNAL","",m$ID)
m$ID <- gsub("\\(|\\)","",m$ID) # first remove brackets from keywords (which are otherwise not recognized)
m$ID <- gsub("LIFE CYCLE ASSESSMENT LCA|LIFE CYCLE ANALYSIS|LIFE-CYCLE ASSESSMENT","LIFE CYCLE ASSESSMENT",m$ID)
m$ID <- gsub("LCA","LIFE CYCLE ASSESSMENT",m$ID)
m$ID <- gsub("SUSTAINABILITY|SUSTAINABLE DEVELOPMENT","SUSTAINAB*",m$ID)
m$ID <- gsub("BUSINESS MODELS","BMS*",m$ID)
m$ID <- gsub("WASTE WATER","WASTEWATER",m$ID)
m$ID <- gsub("WASTES","WASTE",m$ID)
m$ID <- gsub("BIOFUELS","BIOFUEL",m$ID)
m$ID <- gsub("MODELS","MODEL",m$ID)
m$ID <- gsub("HUMANS","HUMAN",m$ID)
m$ID <- gsub("REVIEWS","REVIEW",m$ID)
m$ID <- gsub("SYSTEMS","SYSTEM",m$ID)
m$ID <- gsub("MANUFACTURE","MANUFACTURING",m$ID)
m$ID <- gsub("ECO-DESIGNS","ECODESIGN",m$ID)
m$ID <- gsub("INDUSTRIES","INDUSTRY",m$ID)
m$ID <- gsub("EFFICIENCIES","EFFICIENCY",m$ID)
m$ID <- gsub("CHAINS","CHAIN",m$ID)
m$ID <- gsub("DEVELOPING-COUNTRIES|DEVELOPING COUNTRIES","DEVELOPING COUNTRY",m$ID)
m$ID <- gsub("RESOURCES","RESOURCE",m$ID)
m$ID <- gsub("BUILDINGS","BUILDING",m$ID)
m$ID <- gsub("MATERIALS","MATERIAL",m$ID)
m$ID <- gsub("ENVIRONMENTAL IMPACTS","ENVIRONMENTAL IMPACT",m$ID)
m$ID <- gsub("FERTILIZERS","FERTILIZER",m$ID)
m$ID <- gsub("LAND FILL","LANDFILL",m$ID)
m$ID <- gsub("GREENHOUSE GASES","GREENHOUSE GAS",m$ID)
m$ID <- gsub("INVESTMENTS","INVESTMENT",m$ID)
m$ID <- gsub("CHALLENGES","CHALLENGE",m$ID)
m$ID <- gsub("TECHNOLOGIES","TECHNOLOGY",m$ID)
m$ID <- gsub("ECONOMIC ACTIVITIES","ECONOMIC ACTIVITY",m$ID)
m$ID <- gsub("PLASTICS","PLASTIC",m$ID)
m$ID <- gsub("PRODUCT-SERVICE SYSTEMS","PRODUCT SERVICE SYSTEM",m$ID)
m$ID <- gsub("BIOREFINERIES","BIOREFINERY",m$ID)
m$ID <- gsub("METALS","METAL",m$ID)
m$ID <- gsub("NATURAL RESOURCES","NATURAL RESOURCE",m$ID)
m$ID <- gsub("ECOSYSTEMS","ECOSYSTEM",m$ID)
m$ID <- gsub("NUTRIENTS","NUTRIENT",m$ID)
m$ID <- gsub("EFFLUENTS","EFFLUENT",m$ID)
m$ID <- gsub("FOSSIL FUELS","FOSSIL FUEL",m$ID)
m$ID <- gsub("ANIMALS","ANIMAL",m$ID)
m$ID <- gsub("BYPRODUCTS","BYPRODUCT",m$ID)
m$ID <- gsub("CITIES","CITY",m$ID)
m$ID <- gsub("COSTS","COST",m$ID)
m$ID <- gsub("ECONOMIES","ECONOMY",m$ID)
m$ID <- gsub("RENEWABLE ENERGIES","RENEWABLE ENERGY",m$ID)
m$ID <- gsub("BUILDINGS","BUILDING",m$ID)
m$ID <- gsub("CEMENTS","CEMENT",m$ID)
m$ID <- gsub("ECOSYSTEM SERVICES","ECOSYSTEM SERVICE",m$ID)
m$ID <- gsub("ENZYMES","ENZYME",m$ID)
m$ID <- gsub("INDUSTRIAL EMISSIONS","INDUSTRIAL EMISSION",m$ID)
m$ID <- gsub("TEXTILES","TEXTILE",m$ID)
m$ID <- gsub("PARKS","PARK",m$ID)
m$ID <- gsub("STRATEGIES","STRATEGY",m$ID)
m$ID <- gsub("WASTE DISPOSAL FACILITIES","WASTE DISPOSAL FACILITY",m$ID)
m$ID <- gsub("MANURES","MANURE",m$ID)

#replace keywords, that otherwise would be erased (don't forget to re-replace afterwards)
m$ID <- gsub("ECONOMIC ANALYSIS","ECONOMIC ANALYSATION",m$ID)
m$ID <- gsub("MATERIAL FLOW ANALYSIS","MATERIAL FLOW ANALYSATION",m$ID)
m$ID <- gsub("COST BENEFIT ANALYSIS|COST-BENEFIT ANALYSIS","COST BENEFIT ANALYSATION",m$ID)

m2 <- m
m2$ID <- gsub("CHINA|ARTICLE|PRIORITY JOURNAL|HUMAN|EUROPEAN UNION|PROCEDURES|OPTIMIZATION|SPAIN|CONCEPTUAL FRAMEWORK|REVIEW|EUROPE|
             |INDUSTRIAL RESEARCH|NONHUMAN|NETHERLANDS|MODEL|COMPARATIVE STUDY|CONTROLLED STUDY|UNITED KINGDOM|FRAMEWORK|
              |EVOLUTION|STRATEGIC APPROACH|SURVEYS|INTEGRATED APPROACH|FEASIBILITY STUDY|ITALY|QUANTITATIVE ANALYSIS|ASIA|
              |NUMERICAL MODEL|PERSPECTIVE|RESEARCH WORK|THEORETICAL STUDY|ANALYSIS|BELGIUM|CHEMICAL ANALYSIS|METHODOLOGY|
              |SENSITIVITY ANALYSIS|LITERATURE REVIEW|UNCLASSIFIED DRUG","",m2$ID) #delete keywords

#re-replacement of keywords, that should not be affected by erasing process
m3 <- m2
m3$ID <- gsub("ECONOMIC ANALYSATION","ECONOMIC ANALYSIS",m3$ID)
m3$ID <- gsub("MATERIAL FLOW ANALYSATION","MATERIAL FLOW ANALYSIS",m3$ID)
m3$ID <- gsub("COST BENEFIT ANALYSATION","COST BENEFIT ANALYSIS",m3$ID)

MCESUS <- m3 # to keep it backed up


# CESUS "DE" -----------------------------------------------------------------------------------
# delete Keywords in the column DE 


# replace keywords
n <- MCESUS
n$DE <- gsub("PRIORITY JOURNAL","",n$DE)
n$DE <- gsub("\\(|\\)","",n$DE) # first remove brackets from keywords (which are otherwise not recognized)
n$DE <- gsub("LIFE CYCLE ASSESSMENT LCA|LIFE CYCLE ANALYSIS|LIFE-CYCLE ASSESSMENT","LIFE CYCLE ASSESSMENT",n$DE)
n$DE <- gsub("circular economy ce", "CIRCULAR ECONOMY",n$DE) # use | (= logical OR) between different keywords
n$DE <- gsub("LCA","LIFE CYCLE ASSESSMENT",n$DE)
n$DE <- gsub("SUSTAINABILITY|SUSTAINABLE DEVELOPMENT","SUSTAINAB*",n$DE)
n$DE <- gsub("BUSINESS MODELS","BMS*",n$DE)
n$DE <- gsub("WASTE WATER","WASTEWATER",n$DE)
n$DE <- gsub("WASTES","WASTE",n$DE)
n$DE <- gsub("BIOFUELS","BIOFUEL",n$DE)
n$DE <- gsub("MODELS","MODEL",n$DE)
n$DE <- gsub("HUMANS","HUMAN",n$DE)
n$DE <- gsub("REVIEWS","REVIEW",n$DE)
n$DE <- gsub("SYSTEMS","SYSTEM",n$DE)
n$DE <- gsub("MANUFACTURE","MANUFACTURING",n$DE)
n$DE <- gsub("ECO-DESIGNS","ECODESIGN",n$DE)
n$DE <- gsub("INDUSTRIES","INDUSTRY",n$DE)
n$DE <- gsub("EFFICIENCIES","EFFICIENCY",n$DE)
n$DE <- gsub("CHAINS","CHAIN",n$DE)
n$DE <- gsub("DEVELOPING-COUNTRIES|DEVELOPING COUNTRIES","DEVELOPING COUNTRY",n$DE)
n$DE <- gsub("RESOURCES","RESOURCE",n$DE)
n$DE <- gsub("BUILDINGS","BUILDING",n$DE)
n$DE <- gsub("MATERIALS","MATERIAL",n$DE)
n$DE <- gsub("ENVIRONMENTAL IMPACTS","ENVIRONMENTAL IMPACT",n$DE)
n$DE <- gsub("FERTILIZERS","FERTILIZER",n$DE)
n$DE <- gsub("LAND FILL","LANDFILL",n$DE)
n$DE <- gsub("GREENHOUSE GASES","GREENHOUSE GAS",n$DE)
n$DE <- gsub("INVESTMENTS","INVESTMENT",n$DE)
n$DE <- gsub("CHALLENGES","CHALLENGE",n$DE)
n$DE <- gsub("TECHNOLOGIES","TECHNOLOGY",n$DE)
n$DE <- gsub("ECONOMIC ACTIVITIES","ECONOMIC ACTIVITY",n$DE)
n$DE <- gsub("PLASTICS","PLASTIC",n$DE)
n$DE <- gsub("PRODUCT-SERVICE SYSTEMS","PRODUCT SERVICE SYSTEM",n$DE)
n$DE <- gsub("BIOREFINERIES","BIOREFINERY",n$DE)
n$DE <- gsub("METALS","METAL",n$DE)
n$DE <- gsub("NATURAL RESOURCES","NATURAL RESOURCE",n$DE)
n$DE <- gsub("ECOSYSTEMS","ECOSYSTEM",n$DE)
n$DE <- gsub("NUTRIENTS","NUTRIENT",n$DE)
n$DE <- gsub("EFFLUENTS","EFFLUENT",n$DE)
n$DE <- gsub("FOSSIL FUELS","FOSSIL FUEL",n$DE)
n$DE <- gsub("ANIMALS","ANIMAL",n$DE)
n$DE <- gsub("BYPRODUCTS","BYPRODUCT",n$DE)
n$DE <- gsub("CITIES","CITY",n$DE)
n$DE <- gsub("COSTS","COST",n$DE)
n$DE <- gsub("ECONOMIES","ECONOMY",n$DE)
n$DE <- gsub("RENEWABLE ENERGIES","RENEWABLE ENERGY",n$DE)
n$DE <- gsub("BUILDINGS","BUILDING",n$DE)
n$DE <- gsub("CEMENTS","CEMENT",n$DE)
n$DE <- gsub("ECOSYSTEM SERVICES","ECOSYSTEM SERVICE",n$DE)
n$DE <- gsub("ENZYMES","ENZYME",n$DE)
n$DE <- gsub("INDUSTRIAL EMISSIONS","INDUSTRIAL EMISSION",n$DE)
n$DE <- gsub("TEXTILES","TEXTILE",n$DE)
n$DE <- gsub("PARKS","PARK",n$DE)
n$DE <- gsub("STRATEGIES","STRATEGY",n$DE)
n$DE <- gsub("WASTE DISPOSAL FACILITIES","WASTE DISPOSAL FACILITY",n$DE)
n$DE <- gsub("MANURES","MANURE",n$DE)

#different to the ID replacement
n$DE <- gsub("CIRCULAR ECONOMY (CE)","CIRCULAR ECONOMY",n$DE) #different from above 

#replace keywords, that otherwise would be erased (don't forget to re-replace afterwards)
n$DE <- gsub("ECONOMIC ANALYSIS","ECONOMIC ANALYSATION",n$DE)
n$DE <- gsub("MATERIAL FLOW ANALYSIS|MATERIAL FLOW ANALYIS (MFA)","MATERIAL FLOW ANALYSATION",n$DE)
n$DE <- gsub("COST BENEFIT ANALYSIS|COST-BENEFIT ANALYSIS","COST BENEFIT ANALYSATION",n$DE)

n2 <- n
n2$DE <- gsub("CHINA|ARTICLE|PRIORITY JOURNAL|HUMAN|EUROPEAN UNION|PROCEDURES|OPTIMIZATION|SPAIN|SWEDEN|CONCEPTUAL FRAMEWORK|REVIEW|EUROPE|
#              |INDUSTRIAL RESEARCH|NONHUMAN|NETHERLANDS|MODEL|COMPARATIVE STUDY|CONTROLLED STUDY|UNITED KINGDOM|FRAMEWORK|
#               |EVOLUTION|STRATEGIC APPROACH|SURVEYS|INTEGRATED APPROACH|FEASIBILITY STUDY|ITALY|QUANTITATIVE ANALYSIS|ASIA|
#               |SENSITIVITY ANALYSIS|LITERATURE REVIEW|UNCLASSIFIED DRUG","", n2$DE) #delete keywords


# re-replacement of keywords, that should not be affected by erasing process
n3 <- n2
n3$DE <- gsub("ECONOMIC ANALYSATION","ECONOMIC ANALYSIS",n3$DE)
n3$DE <- gsub("MATERIAL FLOW ANALYSATION|MATERIAL FLOW ANALYSATION (MFA)", "MATERIAL FLOW ANALYSIS", n3$DE)
n3$DE <- gsub("COST BENEFIT ANALYSATION","COST BENEFIT ANALYSIS",n3$DE)
n <- n3 
MCESUS <- n3

# # saveRDS (OPTIONAL)
# saveRDS(MCE, file = "data/MCE.RDS" )  # OPTIONAL
# saveRDS(MCESUS, file = "data/MCESUS.RDS" )  # OPTIONAL
