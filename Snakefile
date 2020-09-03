configfile: "config.yaml"
    
rule all:
    input:
        {sample}.assembly.pdf #FIXME : check quast output
        
rule quality_fastq:
    input:
        R1 = {sample}_R1_{run_number}.fastq,
        R2 = {sample}_R2_{run_number}.fastq
    output:
        {sample}_{run_number}.fastq.pdf
    params:
        faqcs = config["faqcs"]
    shell:
        "{params.faqcs} -1 "

rule assembly:
    conda:
        envs/spades.yaml
    input:
        {sample}.fastq
    output:
        {sample}.fasta

rule quality_assembly:
    conda:
        envs/quast.yaml
    input:
        {sample}.fasta
    output:
        {sample}.assembly.pdf
