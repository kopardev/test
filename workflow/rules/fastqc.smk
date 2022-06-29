def get_input_fastq(wildcards):
    fastqs=[]
    for s in SAMPLES:
        fastqs.append(join(FASTQDIR,s+".R1.fastq.gz"))
    return fastqs


rule fastqc:
    input:
        get_input_fastq()
    output:
        join(WORKDIR,'fastqc','{sample}_fastqc.html')
    envmodules:
        "fastqc/0.27"
    container: "docker://nciccbr/ccbr_fastqc:latest"
    shell:"""
outdir=$(basedir {output})
fastqc -i {input} -o $outdir
    """
    