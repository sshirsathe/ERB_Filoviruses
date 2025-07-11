from Bio import SeqIO
import re

#list of loc numbers corresponding to 22 IFNW genes with the exception of the 5 IFNWs of interest
exclude_loc = ["LOC107518591","LOC107507172","LOC107507180","LOC107507176","LOC107507178","LOC107509254","LOC107511193","LOC107506780",
               "LOC107506690","LOC107508425","LOC107508427","LOC107507613","LOC107507616","LOC107508853","LOC107509925","LOC107510473",
               "LOC107510817"]

records = list(SeqIO.parse("rna.fna", "fasta"))
seqs=[]

#remove loc numbers in the list from the ref genome
for r in records:
    #print(r.description)
    ctr=0
    for s in exclude_loc:
        if s in r.description:
            ctr = ctr +1
    if ctr == 0:
        seqs.append(r)

SeqIO.write(seqs, "rna.fna_modified.fasta", "fasta")
