source("loader/new_user_day_edits.R")
source("loader/new_user_impressions.R")

day_edits = load_new_user_day_edits(reload=T)
impressions = load_new_user_impressions(reload=T)

merged_users = merge(
	day_edits,
	impressions,
	by=c("wiki_db", "user_id")
)
merged_users$registration_day = with(
	merged_users, 
	as.Date(
		paste(
			substr(user_registration, 1, 4),
			substr(user_registration, 5, 6),
			substr(user_registration, 7, 8),
			sep="-"
		)
	)
)
merged_users$simple_action = factor(with(
	merged_users,
	sapply(
		action, 
		function(a){
			a = as.character(a)
			if(a == "view"){
				a
			}else if(a == "history"){
				a
			}else if(a == "edit"){
				a
			}else{
				"(other)"
			}
		}
	)
), levels=c("view", "history", "edit", "(other)"))
merged_users$simple_namespace = factor(with(
	merged_users,
	sapply(
		page_namespace, 
		function(ns){
			if(ns == 0){
				"Main"
			}else if(ns == 1){
				"Talk"
			}else if(ns == -1){
				"Special"
			}else{
				"(other)"
			}
		}
	)
), levels=c("Main", "Talk", "Special", "(other)"))
merged_users$simple_cta_type = factor(with(
	merged_users,
	sapply(
		cta_type, 
		function(cta){
			if(is.na(cta)){
				NA
			}else if(cta == "edit current"){
				"current"
			}else if(cta == "suggested"){
				"suggest"
			}else if(cta == "edit current or suggested"){
				"current&suggest"
			}else{
				NA
			}
		}
	)
), levels=c("current", "suggest", "current&suggest"))
merged_users$simple_revisions = factor(with(
	merged_users,
	sapply(
		day_revisions, 
		function(revs){
			if(revs == 0){
				"0"
			}else if(revs >= 1 & revs <= 4){
				"1-4"
			}else{ #if(revs >= 5)
				"5+"
			}
		}
	)
), levels=c("0", "1-4", "5+"))
merged_users$simple_gs = factor(with(
	merged_users,
	sapply(
		gs_day_revisions, 
		function(revs){
			if(revs > 0){
				"gs edit"
			}else{
				"no gs edit"
			}
		}
	)
), levels=c("gs edit", "no gs edit"))

all_users = data.table(merged_users)
all_users$wiki_db = "all"

merged_users = rbind(
	merged_users,
	all_users
)


daily_users = merged_users[registration_type == "self",
	list(
		users = length(user_id),
		editors = sum(day_revisions > 0),
		gs_editors = sum(gs_day_revisions > 0)
	),
	list(
		wiki_db,
		registration_day
	)
]

daily_user_actions = merged_users[registration_type == "self",
	list(
		users = length(user_id)
	),
	list(
		wiki_db,
		registration_day,
		simple_action,
		simple_namespace
	)
]

transition.action = merge(
	daily_users,
	daily_user_actions,
	by=c("wiki_db", "registration_day"),
	suffixes=c(".total", ".action")
)[,
	list(
		wiki_db,
		registration_day,
		transition = paste(
			"[registration] --> [action=", 
			simple_action, ", ns=", 
			simple_namespace, "]", sep=""
		),
		k = users.action,
		n = users.total
	)
]

svg("funnels/plots/timeseries.props/action_transition_props.svg",
	height=12,
	width=10)
ggplot(transition.action[n >= 50,]) + 
geom_line(
	aes(
		x=registration_day,
		y=k/n,
		color=wiki_db,
		linetype=(wiki_db != "all")
	)
) + 
facet_wrap(~ transition, ncol=2) + 
scale_x_date("Registration day") + 
scale_y_continuous("Proportion of users") + 
theme_bw()
dev.off()

daily_user_impressions = merged_users[
	registration_type == "self" & !is.na(simple_cta_type),
	list(
		users = length(user_id)
	),
	list(
		wiki_db,
		registration_day,
		simple_action,
		simple_namespace,
		simple_cta_type
	)
]

transition.impression = merge(
	daily_user_actions,
	daily_user_impressions,
	by=c("wiki_db", "registration_day", "simple_action", "simple_namespace"),
	suffixes=c(".action", ".impression")
)[,
	list(
		wiki_db,
		registration_day,
		transition = paste(
			"[action=", 
			simple_action, ", ns=", 
			simple_namespace, "] --> ", 
			"[", simple_cta_type, "]", 
			sep=""
		),
		k = users.impression,
		n = users.action
	)
]

svg("funnels/plots/timeseries.props/impression_transition_props.svg",
	height=6,
	width=10)
ggplot(transition.impression[n >= 50,]) + 
geom_line(
	aes(
		x=registration_day,
		y=k/n,
		color=wiki_db,
		linetype=(wiki_db != "all")
	)
) + 
facet_wrap(~ transition, ncol=2) + 
scale_x_date("Registration day") + 
scale_y_continuous("Proportion of users") + 
theme_bw()
dev.off()

daily_gs_user = merged_users[
	registration_type == "self" & !is.na(simple_cta_type),
	list(
		users = length(user_id)
	),
	list(
		wiki_db,
		registration_day,
		simple_action,
		simple_namespace,
		simple_cta_type,
		simple_gs
	)
]


transition.gs_edits = merge(
	daily_user_impressions,
	daily_gs_user,
	by=c("wiki_db", "registration_day", "simple_action", "simple_namespace", "simple_cta_type"),
	suffixes=c(".impression", ".gs")
)[simple_gs == "gs edit",
	list(
		wiki_db,
		registration_day,
		transition = paste(
			"[action=", 
			simple_action, ", ns=", 
			simple_namespace, "]-", 
			"[", simple_cta_type, "] --> [",
			simple_gs, "]",
			sep=""
		),
		k = users.gs,
		n = users.impression
	)
]

svg("funnels/plots/timeseries.props/gs_edit_transition_props.svg",
	height=6,
	width=10)
ggplot(transition.gs_edits[n >= 50,]) + 
geom_line(
	aes(
		x=registration_day,
		y=k/n,
		color=wiki_db,
		linetype=(wiki_db != "all")
	)
) + 
facet_wrap(~ transition, ncol=2) + 
scale_x_date("Registration day") + 
scale_y_continuous("Proportion of users") + 
theme_bw()
dev.off()

daily_user_revisions = merged_users[
	registration_type == "self" & !is.na(simple_cta_type) & simple_revisions != "0",
	list(
		users = length(user_id)
	),
	list(
		wiki_db,
		registration_day,
		simple_action,
		simple_namespace,
		simple_cta_type,
		simple_gs,
		simple_revisions
	)
]


transition.user_revisions = merge(
	daily_gs_user,
	daily_user_revisions,
	by=c("wiki_db", "registration_day", "simple_action", "simple_namespace", "simple_cta_type", "simple_gs"),
	suffixes=c(".gs", ".revisions")
)[,
	list(
		wiki_db,
		registration_day,
		transition = paste(
			"[", simple_action, ", ", simple_namespace, "]-[", 
			simple_cta_type, "]-[",
			simple_gs, "] --> [",
			simple_revisions, " edits]",
			sep=""
		),
		k = users.revisions,
		n = users.gs
	)
]

svg("funnels/plots/timeseries.props/revisions_transition_props.svg",
	height=16,
	width=10)
ggplot(transition.user_revisions[n >= 50,]) + 
geom_line(
	aes(
		x=registration_day,
		y=k/n,
		color=wiki_db,
		linetype=(wiki_db != "all")
	)
) + 
facet_wrap(~ transition, ncol=2) + 
scale_x_date("Registration day") + 
scale_y_continuous("Proportion of users") + 
theme_bw()
dev.off()

# ^^ filter down to users who made at least one edit
