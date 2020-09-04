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

rule assembly:
    conda:
        "envs/spades.yaml"
    input:
        R1 = config["fastq_path"] + "{sample}_R1_001.fastq.gz",
        R2 = config["fastq_path"] + "{sample}_R2_001.fastq.gz"
    output:
        "{sample}.fasta"
    params:
        prefix = lambda wildcards: wildcards.sample
    log: "spades_{sample}.log"
    threads: 6
    shell:
        """
        spades.py -o . -1 {input.R1} -2 {input.R2} > {log}
        mv scaffolds.fasta {params.prefix}.fasta
        """

rule quality_assembly:
    conda:
        "envs/quast.yaml"
    input:
        genome = "{sample}.fasta",
        reference = config["reference_genome"]
    output:
        "{sample}.assembly_report.pdf"
    params:
        prefix = lambda wildcards: wildcards.sample
    shell:
        """
        quast -o . {input.genome} -r {input.reference}
        mv report.pdf {output}
        """
