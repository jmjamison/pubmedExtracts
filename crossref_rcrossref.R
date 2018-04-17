library('rcrossref')

# notes at: https://github.com/ropensci/rcrossref
# also: https://github.com/CrossRef/rest-api-doc#api-overview
cr_cn(dois = "10.1126/science.169.3946.635", format = "text", style = "apa")
cat(cr_cn(dois = "10.1126/science.169.3946.635", format = "bibtex"))
cr_citation_count(doi = "10.1371/journal.pone.0042793")
cr_funders(query = "NSF")
cr_agency(dois = '10.13039/100000001')
cr_journals(issn = c('1803-2427','2326-4225'))
cr_prefixes(prefixes = c('10.1016','10.1371','10.1023','10.4176','10.1093'))

# PMID to  doi
id_converter("27465130", "pmcid")


# query pubmed using RISmed package

library('RISmed')
search_query <- '"University of California, Los Angeles"[Affiliation] OR "University of California, Los Angeles"[Affiliation] OR "University of California Los Angeles"[Affiliation] OR "University of California at Los Angeles"[Affiliation] OR "University of California of Los Angeles"[Affiliation] OR "University of California in Los Angeles"[Affiliation] OR UCLA[Affiliation] OR 90095[Affiliation]) AND ("2014/01/01"[PDAT] : "2018/01/31"[PDAT]'
# create the query
results <- EUtilsQuery(search_query, type="esearch", db="pubmed")

# get summary info on the results of a query
fetch <-EUtilsSummary(results, type="esearch", db="pubmed", retmax=50)
View(idList)
idList <- QueryId(fetch) # list out
typeof(idList)
idFrame <- data.frame(idList)
View(idFrame)

summary(fetch) # count number
QueryTranslation(fetch) 


# download resurlts of a query
getResultes <- EUtilsGet(fetch, type="efetch", db="pubmed")
PMID(getResultes)  # get results of returned query
Mesh(getResultes)   #extract MESH headings
Author(getResultes)
Cited(getResultes) # retreives the number of citations for the articls
PMID(getResultes)
Title(getResultes)
#str(getResultes) # dumps everything
Cited(getResultes) # counts citations

View(getResultes)
summary(getResultes)
articleIDs <- getResultes@ArticleId
View(articleIDs)
Title(getResultes)

library('RISmed')
search_query <- '"University of California, Los Angeles"[Affiliation] OR "University of California, Los Angeles"[Affiliation] OR "University of California Los Angeles"[Affiliation] OR "University of California at Los Angeles"[Affiliation] OR "University of California of Los Angeles"[Affiliation] OR "University of California in Los Angeles"[Affiliation] OR UCLA[Affiliation] OR 90095[Affiliation]) AND ("2014/01/01"[PDAT] : "2018/01/31"[PDAT]'
# create the query
results <- EUtilsQuery(search_query, type="esearch", db="pubmed", retmax=500)


# get summary info on the results of a query
summaryIds <-EUtilsSummary(results, type="esearch", db="pubmed", retmax=10, retstart=10)
QueryId(summaryIds) # list out
summary(summaryIds) # count number
QueryTranslation(summaryIds) 

# download resurlts of a query
getResultes <- EUtilsGet(fetch, type="efetch", db="pubmed")
PMID(getResultes)  # get results of returned query
pmidResults <- PMID(getResultes)
typeof(pmidResults)
View(pmidResults)
str(pmidResults)
pmidDataFrame <- data.frame(pmidResults)
str(pmidDataFrame)
View(pmidDataFrame)

class(getResultes) # info about package and database

# str(getResultes) # dumps everything

library(rentrez)
library(readr)
search_query <- '"University of California, Los Angeles"[Affiliation] OR "University of California, Los Angeles"[Affiliation] OR "University of California Los Angeles"[Affiliation] OR "University of California at Los Angeles"[Affiliation] OR "University of California of Los Angeles"[Affiliation] OR "University of California in Los Angeles"[Affiliation] OR UCLA[Affiliation] OR 90095[Affiliation]) AND ("2014/01/01"[PDAT] : "2018/01/31"[PDAT]'
# create the query

library(readr)
pubmed_result <- read_csv("work/Sharon-Schaffer/pubmed_result.csv")
View(pubmed_result)

entrez_search(db="pubmed", term=search_query, retmax=50)
#entrez_fetch(db="pubmed", id=pubmed_search$ids, rettype="csv")
getIds <- entrez_fetch(db="pubmed", id=pubmed_search$ids, rettype="csv", retmax=50, restart=10)
typeof(getIds)
idList <- list(getIds)
typeof(idList)
View(idList)
is.character(getIds)
length(getIds)


# using rentrez
library(rentrez)
entrez_dbs()  # available databases
entrez_db_searchable("pubmed") #searchable databases
r_search <- entrez_search(db='pubmed', term=search_query, retmax=40)
pmid_list <- r_search$ids
View(pmid_list)
test_summary <- entrez_summary(db="pubmed", id="29637000") # items you can search for
test_summary
test_summary$authors
test_summary$title
multi_responses <- entrez_summary(db="pubmed", id=r_search$ids)
View(multi_responses)
pubdate_estract <- extract_from_esummary(multi_responses, "pubdate")
View(pubdate_estract)
title_extract <- extract_from_esummary(multi_responses, "title")
author_extract <- extract_from_esummary(multi_responses, "author")
View(title_extract)
View(author_extract)
author_title_extract <- extract_from_esummary(multi_responses, c("title", "pubdate", "author"))
View(author_title_extract)
testFrame <- data.frame(pubdate_estract, title_extract, author_extract)
View(testFrame)
str(testFrame)
