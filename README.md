# README
- - - -

###  Description of the supporting information, including a review protocol, scripts and data to generate the results and visualisations of the paper “The narrative of sustainability and circular economy – a longitudinal review of two decades of research” by Schöggl, J.-P., Stumpf, L., and Baumgartner, R.J.,

The detailed information about the computer/software set up is available from sessionInfo.txt
- - - -
CONTENT
1. Review Protocol
2. R scripts
	a) 0_load_and_clean_data.R
	b) 1_thematic_maps.R
	c) 2_conceptual_structure.R
	d) 3_correlated_topic_model.R
	e) 4_historiographic_analysis.R
3. Data
	a) scopusCE1.bib 
	b) scopusCE2.bib
	c) wosCE1.bib
	d) wosCE2.bib
	e) wosCE3.bib
	f) wosCE4.bib
	g) wosCE5.bib
	h) wosCE6.bib
	i) wosCE7.bib
	j) scopusCESUS.bib
	k) wosCESUS1.bib
	l) wosCESUS2.bib
	m) wosCESUS3.bib
	n) wosCESUS4.bib
	o) MCE.RDS
	p) MCESUS.RDS
4. Networks
  a) Thematic_network_2000-2012.pdf
  b) Thematic_network_2013-2015.pdf
  c) Thematic_network_2016-2018.pdf
  d) Thematic_network_2019.pdf
  e) Thematic_network_2000-2012.net
  f) Thematic_network_2013-2015.net
  g) Thematic_network_2016-2018.net
  h) Thematic_network_2019.pdf
  
- - - -
1. Review protocol

The review protocol in the file Review_protocol.pdf summarises the research steps taken in the analyses described in sections 4.1-4.5 of the paper and links these analyses to the respective R-scripts.

- - - -
2. R-scripts 

a) 0_load_and_clean_data.R – prepares two data-frames (MCE, MCESUS) used in the analysis in scripts 1-4; is sources from scripts 1-4.; requires all .bib files in the folder /data in the working directory

b) 1_thematic_maps.R – creates the four thematic maps; requires 0_load_and_clean_data.R

c) 2_conceptual_structure.R – runs the Multiple Correspondence Analysis and k-means clustering; requires 0_load_and_clean_data.R

d) 3_correlated_topic_model.R – fits the correlated topic model; requires 0_load_and_clean_data.R 

e) 4_historiographic_analysis.R - performs the historiographic network analysis that is used also as a basis for the subsequent qualitative analysis; requires 0_and_clean_data.R

- - - -
The two data frames MCE and MCESUS created via 0_load_and_clean_data.R and that are used in scripts 1-4 both contain following variables: 

AU: 	Authors
TI: 	Document title
SO: 	Publication source
JI:	ISO Source Abbreviation
DE:	Authors’ Keywords
ID:	Keywords associated by SCOPUS or ISI database
LA: 	Language
DT:	Document Type
CR:	Cited References
AB: 	Abstract
C1:	Author Address
RP:	Reprint Address
TC:	Times Cited
PY:	Year
SC:	Subject Category
UT:	Unique Article Identifier
DB:	Bibliographic Database

- - - -
3. Data 
The datasets a)-n) in the folder “/data” in the working directory are BibTeX files extracted from the Web of Science and Scopus databases. The keywords and settings used for extracting them can be found in the script 0_load_and_clean_data.R and in the file Review_protocol.pdf. The two files "MCE.RDS" and "MCESUS.RDS" in the folder "/data" comprise the two dataframes used in scripts 1-4, and instead of creating them from new with script 0, they  can be loaded directly in scripts 1-4. 

- - - -
4. Networks
The files a)-d) in the folder "/networks" are vector graphs of the thematic networks that are underlying the four thematic maps in section 4.1. Files e)-h) are the corresponding network files were used to plot the graphs.
