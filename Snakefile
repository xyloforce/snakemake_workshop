configfile: "config.yaml"
    
rule quality_fastq:
    input:
        R1 = config["fastq_path"] + "{sample}_R1_001.fastq",
        R2 = config["fastq_path"] + "{sample}_R2_001.fastq"
    output:
        "{sample}.fastq.pdf"
    params:
        faqcs = config["faqcs"],
        filename = lamba wildcards: wildcards.sample
    shell:
        "{params.faqcs} -1 {input.R1} -2 {input.R2} --prefix {params.filename}"

#rule assembly:
    #conda:
        #"envs/spades.yaml"
    #input:
        #"{filename}.fastq"
    #output:
        #"{filename}.fasta"
    #shell:
        #""

#rule quality_assembly:
    #conda:
        #"envs/quast.yaml"
    #input:
        #"{filename}.fasta"
    #output:
        #"{filename}.assembly.pdf"
    #shell:
        #"quast"
