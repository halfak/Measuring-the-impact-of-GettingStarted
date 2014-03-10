source("env.R")
source("util.R")

load_newly_registered_users = tsv_loader(
	paste(DATA_DIR, "newly_registered_users.tsv", sep="/"),
	"NEWLY_REGISTERED_USERS"
)
