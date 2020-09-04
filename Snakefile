configfile: "config.yaml"
    
rule quality_fastq:
    input:
        R1 = config["fastq_path"] + "{sample}_R1_001.fastq.gz",
        R2 = config["fastq_path"] + "{sample}_R2_001.fastq.gz"
    output:
        "{sample}_qc_report.pdf"
    params:
        faqcs = config["faqcs"],
        prefix = lambda wildcards: wildcards.sample
    shell:
        "{params.faqcs} -1 {input.R1} -2 {input.R2} --prefix {params.prefix} -d ."

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
