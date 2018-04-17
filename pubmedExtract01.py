# you need to install Biopython:
# pip install biopython

# Full discussion:
# https://marcobonzanini.wordpress.com/2015/01/12/searching-pubmed-with-python/

from Bio import Entrez
from Bio.Entrez import efetch 

import json

query='("University of California, Los Angeles"[Affiliation] OR "University of California, Los Angeles"[Affiliation] OR "University of California Los Angeles"[Affiliation] OR "University of California at Los Angeles"[Affiliation] OR "University of California of Los Angeles"[Affiliation] OR "University of California in Los Angeles"[Affiliation] OR UCLA[Affiliation] OR 90095[Affiliation]) AND ("2014/01/01"[PDAT] : "2018/01/31"[PDAT])'

handle = Entrez.esearch(db="pubmed", term=query,retmode'"xml")
record = Entrez.read(handle)
print(record)
