#!/usr/bin/env nextflow

params.outdir       = "$projectDir/results"

//Create channels
sample_sheet_ch = Channel.fromPath("chater_diehl_sample_sheet.csv")
data_dir_ch     = Channel.fromPath("$projectDir/GSE125367_RAW")  

//Process 1: Pre-process the raw methylation data
process preprocessMeth {

    tag "preprocessMeth"

    publishDir "${params.outdir}/01_preprocess", mode: 'copy'

    input:
    path sample_sheet
    path data_dir

    output:
    path "bVals.rds"
    path "targets.csv"

    script:
    """
    Rscript $projectDir/bin/preprocessing.R $sample_sheet $data_dir 
    """
}

//Process 2: Run DMP analysis
process runDMPs { 
    tag "runDMPs"

    publishDir "${params.outdir}/02_diffMeth", mode: 'copy'

    input:
    path bvals_file
    path targets_file

    output:
    path "DMPs_results.csv"
    script:
    """
    Rscript $projectDir/bin/runDMPs.R $bvals_file $targets_file
    """
    }

//Process 3: GO enrichment analysis and plotting top GO terms
process goAnalysis {

    tag "goAnalysis"

    publishDir "${params.outdir}/03_GO", mode: 'copy'

    input:
    path dms_file

    output:
    path "goTerms.csv"
    path "topGOterms.pdf"

    script:
    """
    Rscript $projectDir/bin/goAnalysis.R $dms_file 
    """

}

workflow {
    // Process 1: Pre-process the raw methylation data
    preprocessMeth(
        sample_sheet_ch,
        data_dir_ch,
        )
    .set { preprocessMeth_out }

    // Process 2: Run DMP analysis
    runDMPs(
        preprocessMeth_out[0],
        preprocessMeth_out[1])
    .set { runDMPs_out }

    //Process 3: GO enrichment analysis 
    goAnalysis(runDMPs_out)



    //(preprocessMeth_targets, preprocessMeth_bvals) = preprocessMeth(
    //    sample_sheet_ch,
      //  data_dir_ch,
    //)

    //runDMPs_out = runDMPs(
     //   preprocessMeth_bvals,
       // preprocessMeth_targets,
    //)

    //goAnalysis(runDMPs_out)
}