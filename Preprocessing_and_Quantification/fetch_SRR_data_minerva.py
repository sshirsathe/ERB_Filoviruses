import subprocess 
import os
import fnmatch
#ml python/3.10.4 kallisto, sratoolkit, and delete all the previous output folders (everything in output, the SRR... folders im the current directory

#example sample set
#****************************
sra_numbers = ["ERR6510455", "ERR6510456", "ERR6510457", "ERR6510458", "ERR6510459", "ERR6510460", "ERR6510463", "ERR6510464", "ERR6510471", "ERR6510472", "ERR6510473", "ERR6510474", "ERR6510475", "ERR6510476", "ERR6510477", "ERR6510478", "ERR6510479", "ERR6510481", "ERR6510480", "ERR6510482", "ERR6510483", "ERR6510484", "ERR6510485", "ERR6510486", "ERR6510487", "ERR6510488", "ERR6510489", "ERR6510490", "ERR6510491", "ERR6510492"]

# this will download the .sra files to ~/ncbi/public/sra/ (will create directory if not present)
for sra_id in sra_numbers:
    print ("Currently downloading: " + sra_id)
    prefetch = "prefetch " + sra_id
    print ("The command used was: " + prefetch)
    subprocess.call(prefetch, shell=True)

# this will extract the .sra files from above into a folder named 'fastq'
for sra_id in sra_numbers:
    print ("Generating fastq for: " + sra_id) 
    fastq_dump = f'fasterq-dump --outdir fastq/Schneor_2023_fastq_data/{sra_id} --progress {sra_id}'    
    #                                         *************************
    print ("The command used was: " + fastq_dump)
    subprocess.call(fastq_dump, shell=True)

for sra_num in sra_numbers:
    change_name = f'mv /sc/arion/projects/BAT-NATIVE/SRR_Data/outputs/abundance.tsv /sc/arion/projects/BAT-NATIVE/SRR_Data/outputs/{sra_num}_abundance.tsv'
    # folder path
    dir_path = f'/sc/arion/projects/BAT-NATIVE/SRR_Data/fastq/Schneor_2023_fastq_data/{sra_num}/'
    #                                                        *************************
    count = 0
    # Iterate directory
    for path in os.listdir(dir_path):
     # check if current path is a file
        if os.path.isfile(os.path.join(dir_path, path)):
           count += 1
    pattern = sra_num + "*"
    files = os.listdir(f'/sc/arion/projects/BAT-NATIVE/SRR_Data/fastq/Schneor_2023_fastq_data/{sra_num}/') 
    #                                                                *************************
    matches = fnmatch.filter(files, pattern)
    for match in matches:
        print(match)
        unzip = f'gzip -d /sc/arion/projects/BAT-NATIVE/SRR_Data/fastq/Schneor_2023_fastq_data/{sra_num}/{match}'
        #                                                             *************************
        subprocess.call(unzip, shell=True)

    pattern_new = sra_num + "*.fastq*"
    files_new = os.listdir(f'/sc/arion/projects/BAT-NATIVE/SRR_Data/fastq/Schneor_2023_fastq_data/{sra_num}/')
    #                                                                    *************************
    matches_new = fnmatch.filter(files_new, pattern_new)
    if count==1:
       fasta_1 = matches_new[0]       
       #                                       ***********************
       generate_abundance = f'kallisto quant -i kallisto_idx_dec_13.idx -o outputs --single -l 31 -s 25 /sc/arion/projects/BAT-NATIVE/SRR_Data/fastq/Schneor_2023_fastq_data/{sra_num}/{fasta_1}'
    #                *************************
    if count==2:
       fasta_1 = matches_new[1]   
       fasta_2 = matches_new[0]
       #                                       ***********************
       generate_abundance = f'kallisto quant -i kallisto_idx_dec_13.idx -o outputs /sc/arion/projects/BAT-NATIVE/SRR_Data/fastq/Schneor_2023_fastq_data/{sra_num}/{fasta_1} /sc/arion/projects/BAT-NATIVE/SRR_Data/fastq/Schneor_2023_fastq_data/{sra_num}/{fasta_2}'
       #            *************************
       #            *************************
    print("generating abundance with the following command")
    print(generate_abundance)
    subprocess.call(generate_abundance, shell=True)
    subprocess.call(change_name, shell=True)

#rename the abundance h5 file so that it is not considererd in tximport
move = f'mv /sc/arion/projects/BAT-NATIVE/SRR_Data/outputs/abundance.h5 /sc/arion/projects/BAT-NATIVE/SRR_Data/outputs/original.h5'
subprocess.call(move, shell=True)
