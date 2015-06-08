# set working directory to the folder containing the 'german' folder
# setwd('/Users/David/Documents/Uni/4-SS15/Introduction to cognitive models of language processing/project/data/')

prepareData <- function( uri ){
  gpw <- read.table('german/gpw/gpw.cd', header=FALSE, sep='\\', fill=TRUE, quote="")
  names(gpw) <- c('IdNum','Word','Mann','IdNumLemma','PhonStrsDISC','PhonSylBCLX','PhonCVBr')
  
  gpl <- read.table('german/gpl/gpl.cd', header=FALSE, sep='\\', fill=TRUE, quote="")
  names(gpl) <- c('IdNum','Head','Mann','PhonStrsDISC','PhonSylBCLX', 'PhonStrsStDISC','PhonSylStBCLX','PhonCVBr','PhonStCVBr','PhonolSAM','PhonolCLX')
  
  gml <- read.table('german/gml/gml.cd', header=FALSE, sep='\\', fill=TRUE, quote="")
  names(gml) <- c('IdNum','Head','Mann','MorphStatus','MorphCnt','DerComp','Comp','Def','Imm','ImmClass','ImmAllo','ImmOpac', 'ImmUml', 'StrucLab', 'StrucAllo', 'StrucOpac', 'StrucUml', 'Sepa', 'InflPar', 'InflVar')
  
  gp <- merge(gpw, gpl, by.x="IdNumLemma", by.y="IdNum", suffixes = c(".w",".l"))
  
  data <- data.frame(Word = gp$Word, 
                     DISC = gp$PhonStrsDISC.w, 
                     WordFrequency = gp$Mann.w,
                     Lemma = gp$Head,
                     LemmaFrequency = gp$Mann.l)

  write.csv(data, file=uri)
  return( data )
}

# writes and returns prepared data 
# ! this takes a while !
data <- prepareData("dat.csv")  

# load the prepared data from file
# data <- read.csv("dat.csv")  
