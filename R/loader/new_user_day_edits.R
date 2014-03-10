source("env.R")
source("util.R")

load_new_user_day_edits = tsv_loader(
	paste(DATA_DIR, "new_user_day_edits.tsv", sep="/"),
	"NEW_USER_DAY_EDITS"
)
