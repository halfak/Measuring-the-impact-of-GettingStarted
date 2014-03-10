source("env.R")
source("util.R")

load_gs_wikis = tsv_loader(
	paste(DATA_DIR, "gs_wikis.tsv", sep="/"),
	"GS_WIKIS"
)
