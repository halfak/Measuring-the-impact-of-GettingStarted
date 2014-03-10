source("loader/newly_registered_users.R")
source("loader/new_user_impressions.R")
source("loader/gs_wikis.R")

wikis = load_gs_wikis(reload=T)
wikis$deployment = as.POSIXct(as.character(wikis$deployment), tz="UTC", format="%Y%m%d%H%M%S")
users = load_newly_registered_users(reload=T)
users$user_registration = as.POSIXct(as.character(users$user_registration), tz="UTC", format="%Y%m%d%H%M%S")
new_user_impressions = load_new_user_impressions(reload=T)

merged.users = merge(
	users,
	new_user_impressions,
	all=T,
	by=c("wiki_db", "user_id")
)

merged.wiki.users = merge(
	merged.users,
	wikis,
	by=c("wiki_db")
)

merged.wiki.users$impressed = !is.na(merged.wiki.users$impressions)

daily_users = merged.wiki.users[,
	list(
		non_mobile_users = sum(!mobile),
		impressed_users = sum(!mobile & impressed),
		impressed_prop = sum(!mobile & impressed)/sum(!mobile)
	),
	list(
		wiki_db,
		deployment,
		registration_day = as.POSIXct(round(user_registration, "days"))
	)
]

svg("deployments/plots/impressed.props/daily_impressed_props.by_wiki.svg",
	width=7,
	height=14)
ggplot(
	daily_users[non_mobile_users >= 5,],
	aes(
		x=registration_day,
		y=impressed_prop
	)
) + 
geom_area(stat="identity", color="black", fill="#CCCCCC") + 
geom_vline(
	aes(xintercept=as.numeric(deployment)),
	linetype=2
) + 
facet_wrap(~ wiki_db, ncol=2) + 
scale_x_datetime("Registration day") + 
scale_y_continuous("GS Impressed Proportion", breaks=c(0, .5, 1)) + 
theme_bw()
dev.off()
