source("env.R")
source("util.R")

load_new_user_impressions = tsv_loader(
	paste(DATA_DIR, "new_user_impressions.tsv", sep="/"),
	"NEW_USER_IMPRESSIONS"
)
