# you need to install Biopython:
# pip install biopython

# Full discussion:
# https://marcobonzanini.wordpress.com/2015/01/12/searching-pubmed-with-python/

from Bio import Entrez
import json

query='("University of California, Los Angeles"[Affiliation] OR "University of California, Los Angeles"[Affiliation] OR "University of California Los Angeles"[Affiliation] OR "University of California at Los Angeles"[Affiliation] OR "University of California of Los Angeles"[Affiliation] OR "University of California in Los Angeles"[Affiliation] OR UCLA[Affiliation] OR 90095[Affiliation]) AND ("2014/01/01"[PDAT] : "2018/01/31"[PDAT])'

print(query)

def search(query):
    Entrez.email = 'jamison@library.ucla.edu'
    handle = Entrez.esearch(db='pubmed', 
                            sort='relevance', 
                            retmax='20',
                            retmode='xml', 
                            term=query)
    results = Entrez.read(handle)
    return results

def fetch_details(id_list):
    ids = ','.join(id_list)
    Entrez.email = 'jamison@library.ucla.edu'
    handle = Entrez.efetch(db='pubmed',
                           retmode='xml',
                           id=ids)
    results = Entrez.read(handle)
    return results

if __name__ == '__main__':
    results = search(query)
    id_list = results['IdList']
    papers = fetch_details(id_list)
    print(results)
    for i, paper in enumerate(papers['PubmedArticle']): print("%d) %s" % (i+1, paper['MedlineCitation']['Article']['ArticleTitle']))
    # Pretty print the first paper in full
    #import json
#print(json.dumps(papers[0], indent=2, separators=(',', ':')))
