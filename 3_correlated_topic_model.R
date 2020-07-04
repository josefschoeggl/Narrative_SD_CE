# Topic Modelling of CE Abstracts

# load data (optional)
MCE <- readRDS("data/MCE.RDS")

# Data preparation  -------------------------------------------------------------------------

# load libraries
library(dplyr)
library(tibble)

# check for NAs
sum(is.na(MCE$AB))

# remove NAs 
MCE <- MCE[!is.na(MCE$AB),] 
doc_desc <- tibble(id = MCE$AU, 
                   desc = MCE$AB)

# delete stopwords
library(tidytext)

doc_desc <- doc_desc %>% 
  unnest_tokens(word, desc) %>% 
  anti_join(stop_words)

# descriptions
worfreq <- doc_desc %>% 
  count(word, sort = TRUE)

# customize stopwords
my_stopwords <- tibble(word = c(as.character(1:10),"paper","study","research","based","results","result","elsevier","main","article","provide","due",
                                "role","rights","reserved", "main","proposed", "time", "data", "high", "literature", "article", "work", "order", "well", "authors",
                                "abstract", "current", "will", "focus", "provide", "approach", "considered", "based", "research", "rights", "reserved", 
                                "2018","2016", "2017", "2015", "2014", "2013", "2012","2011","2010","2009","2008","2007", "2006","2005","2004","2003","2002",
                                "resulting", "resulted", "findings", "finding"))

# remove numbers
doc_desc <-doc_desc[-grep("\\b\\d+\\b", doc_desc$word),]

doc_desc <- doc_desc %>% 
  anti_join(my_stopwords)

word_counts <- doc_desc %>%
  anti_join(my_stop_words) %>%
  count(id, word, sort = TRUE) %>%
  ungroup()

word_counts

# check co-ocurrences and correlations
library(widyr)

desc_word_pairs <- doc_desc %>% 
  pairwise_count(word, id, sort = TRUE, upper = FALSE)
desc_word_pairs

# create the document-term matrix 
desc_dtm <- word_counts %>%
  cast_dtm(id, word, n)

# Determining number of topics --------------------------------------------------

# Needs to be ACTIVATED as it takes several hours to fit the CTM

# # load library
# library(ldatuning)
# 
# # run lda tuner
# result <- FindTopicsNumber(
#   desc_dtm,
#   topics = seq(from = 5, to = 100, by = 5),
#   metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
#   method = "Gibbs",
#   control = list(seed = 77),
#   mc.cores = 2L,
#   verbose = TRUE
# )
# 
# # plot the result
# FindTopicsNumber_plot(result)


# Running the Correlated Topic Model -------------------------------------------------

# Needs to be ACTIVATED as it takes several hours to fit the CTM

# library(topicmodels)
# 
# # be aware that running this model is time intensive
# ctm20 <- CTM(desc_dtm, k = 20, control = list(seed = 1234)) # 
# 
# # save result
# saveRDS(ctm20, file = "ctm20.RDS")


# Prepare data for plots  -------------------------------------------------------

# load libraries
library(topicmodels)
library(dplyr)
library(tidytext)
library(purrr)
library(widyr)
library(tidyr)
library(ggplot2)

# load topic model
desc_ctm <- readRDS(file = "saves/ctm20_2000-2019.RDS") 

# tidy the dataframe
tidy_ctm <- tidy(desc_ctm)

# define top terms
top_terms <- tidy_ctm %>%
  group_by(topic) %>%
  top_n(15, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

# Contribution plot ----------------------------------------------------------------------

# bring topics into the right order
top_terms <- as.data.frame(top_terms)
top_terms$topic_orderd <- ifelse(top_terms$topic == 7, 1,top_terms$topic ) # as we want to change more than one, we have to change the command a bit, so that we don't replace the new variables again with the old ones
top_terms$topic_orderd <- ifelse(top_terms$topic == 19, 2,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 2, 3,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 5, 4,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 17, 5,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 16, 6,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 9, 7,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 13, 8,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 10, 9,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 18, 10,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 1, 11,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 14, 12,top_terms$topic_orderd)
top_terms$topic_orderd <- ifelse(top_terms$topic == 3, 13,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 12, 14,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 4, 15,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 6, 16,top_terms$topic_orderd)
top_terms$topic_orderd <- ifelse(top_terms$topic == 15, 17,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 8, 18,top_terms$topic_orderd ) 
top_terms$topic_orderd <- ifelse(top_terms$topic == 11, 19,top_terms$topic_orderd )
top_terms$topic_orderd <- ifelse(top_terms$topic == 20, 20,top_terms$topic_orderd)


# assign correct order back to the original column
top_terms$topic <- top_terms$topic_orderd


top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  group_by(topic, term) %>%
  arrange(desc(beta)) %>%
  ungroup() %>%
  mutate(term = factor(paste(term, topic, sep = "__"),
                       levels = rev(paste(term, topic, sep = "__")))) %>%
  ggplot(aes(term, beta, fill = as.factor(topic))) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  scale_x_discrete(labels = function(x) gsub("__.+$", "", x)) +
  labs(title = "Top 15 terms in each CTM topic",
       x = NULL, y = expression(beta))+
  facet_wrap(~ topic, ncol = 4, scales = "free")

# # DELETE in PAPER
# outdir <- "C:/Users/Sepp/Dropbox/CDLAB_Working Documents/"
# ggsave(file=paste(outdir, "Contribution.eps", sep=""),width = 15, height = 12, units = "in", dpi =600)

# Distribution plots --------------------------------------------------------------

# create ctm gamma
ctm_gamma <- tidy(desc_ctm, matrix = "gamma")

# Probability distribution all topics
ggplot(ctm_gamma, aes(gamma)) +
  geom_histogram() +
  scale_y_log10() +
  labs(title = "Distribution of probabilities for all topics",
       y = "Number of documents", x = expression(gamma))

# Probability distribution per topic
ggplot(ctm_gamma, aes(gamma, fill = as.factor(topic))) +
  geom_histogram(show.legend = FALSE) +
  facet_wrap(~ topic, ncol = 4) +
  scale_y_log10() +
  labs(title = "Distribution of probability for each topic",
       y = "Number of documents", x = expression(gamma))

# Prevalence plot ------------------------------------------------------------------

# load libraries
library(stm)
library(furrr)
library(bigrquery)
library(tidyverse)
library(topicmodels)
library(dplyr)
library(tidytext)
library(purrr)
library(widyr)
library(tidyr)
library(knitr)
library(scales)
library(ggplot2)

#prepare tds
td_beta <- tidy(desc_ctm)
td_gamma <- tidy(topic_model, matrix = "gamma",
                 document_names = rownames(hacker_news_sparse))


# Let’s combine these to understand the topic prevalence 
library(ggthemes)

top_terms <- td_beta %>%
  arrange(beta) %>%
  group_by(topic) %>%
  top_n(5, beta) %>%  # n can be varied to plot more or less terms
  arrange(-beta) %>%
  select(topic, term) %>%
  summarise(terms = list(term)) %>%
  mutate(terms = map(terms, paste, collapse = ", ")) %>% 
  unnest()

gamma_terms <- td_gamma %>%
  group_by(topic) %>%
  summarise(gamma = mean(gamma)) %>%
  arrange(desc(gamma)) %>%
  left_join(top_terms, by = "topic") %>%
  mutate(topic = paste0("Topic ", topic),
         topic = reorder(topic, gamma))

#rename gamma terms
gamma_terms <- as.data.frame(gamma_terms)
class(gamma_terms$topic)

gamma_terms$topic <- as.character(gamma_terms$topic)
gamma_terms[1,1] <- "Topic 1" # in order to be able to add names to the different topics
gamma_terms[2,1] <- "Topic 2"
gamma_terms[3,1] <- "Topic 3"
gamma_terms[4,1] <- "Topic 4"
gamma_terms[5,1] <- "Topic 5"
gamma_terms[6,1] <- "Topic 6"
gamma_terms[7,1] <- "Topic 7"
gamma_terms[8,1] <- "Topic 8"
gamma_terms[9,1] <- "Topic 9"
gamma_terms[10,1] <- "Topic 10"
gamma_terms[11,1] <- "Topic 11"
gamma_terms[12,1] <- "Topic 12"
gamma_terms[13,1] <- "Topic 13"
gamma_terms[14,1] <- "Topic 14"
gamma_terms[15,1] <- "Topic 15"
gamma_terms[16,1] <- "Topic 16"
gamma_terms[17,1] <- "Topic 17"
gamma_terms[18,1] <- "Topic 18"
gamma_terms[19,1] <- "Topic 19"
gamma_terms[20,1] <- "Topic 20"

gamma_terms$topic <- factor(gamma_terms$topic, levels = c("Topic 20",
                                                          "Topic 19",
                                                          "Topic 18",
                                                          "Topic 17",
                                                          "Topic 16",
                                                          "Topic 15",
                                                          "Topic 14",
                                                          "Topic 13",
                                                          "Topic 12",
                                                          "Topic 11",
                                                          "Topic 10",
                                                          "Topic 9",
                                                          "Topic 8",
                                                          "Topic 7",
                                                          "Topic 6",
                                                          "Topic 5",
                                                          "Topic 4",
                                                          "Topic 3",
                                                          "Topic 2",
                                                          "Topic 1"))


# plot
gamma_terms %>%
  top_n(30, gamma) %>%
  ggplot(aes(topic, gamma, label = terms, fill = topic)) +
  geom_col(show.legend = FALSE) +
  geom_text(hjust = 0, nudge_y = 0.0005, size = 4,
            family = "IBMPlexSans") +
  coord_flip() +
  scale_y_continuous(expand = c(0,0),
                     limits = c(0, 0.25), #adjust the width of the plot with the percentage limit here
                     labels = percent_format()) +
  theme_tufte(base_family = "IBMPlexSans", ticks = FALSE) +
  theme(plot.title = element_text(size = 16,
                                  family="IBMPlexSans-Bold"),
        plot.subtitle = element_text(size = 13)) +
  labs(x = NULL, y = expression(gamma),
       title = "20 Topics by prevalence in Circular Economy research between 2000-2019",
       subtitle = "With the top 5 words that contribute to each topic")


# show kable
gamma_terms %>%
  select(topic, gamma, terms) %>%
  kable(digits = 3, 
        col.names = c("Topic", "Expected topic proportion", "Top 7 terms"))

# create dataframe
CTM_top20 <- gamma_terms %>% 
  select(topic, gamma, terms)
