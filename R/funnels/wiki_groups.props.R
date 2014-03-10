source("loader/new_user_day_edits.R")
source("loader/new_user_impressions.R")

day_edits = load_new_user_day_edits(reload=T)
impressions = load_new_user_impressions(reload=T)

users = merge(
	day_edits,
	impressions,
	by=c("wiki_db", "user_id")
)
users$group = "all"
users$registration_day = with(
	users, 
	as.Date(
		paste(
			substr(user_registration, 1, 4),
			substr(user_registration, 5, 6),
			substr(user_registration, 7, 8),
			sep="-"
		)
	)
)

users$simple_cta_type = factor(with(
	users,
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
users$one_plus = users$day_revisions >= 1
users$five_plus = users$day_revisions >= 5
users$gs_editor = users$gs_day_revisions >= 1

suggestable_users = data.table(
	users[
		wiki_db == "enwiki" |
		wiki_db == "eswiki" | 
		wiki_db == "ukwiki" | 
		wiki_db == "zhwiki",
	]
)
suggestable_users$group = "suggestable"


non_suggestable_users = data.table(
	users[
		wiki_db != "enwiki" &
		wiki_db != "eswiki" & 
		wiki_db != "ukwiki" & 
		wiki_db != "zhwiki",
	]
)
non_suggestable_users$group = "non-suggestable"

grouped_users = rbind(
	non_suggestable_users,
	suggestable_users,
	users
)

user.counts = grouped_users[,
	list(
		users = length(user_id)
	),
	list(
		group
	)
]

impression.counts = grouped_users[,
	list(
		users = length(user_id)
	),
	list(
		group,
		simple_cta_type
	)
]

impression.transition = merge(
	user.counts,
	impression.counts,
	by=c("group"),
	suffixes=c(".total", ".impression")
)[,
	list(
		group,
		transition = paste(
			"[registration] --> ",
			"[", simple_cta_type, "]",
			sep = ""
		),
		k = users.impression,
		n = users.total
	)
]
impression.transition$percentage = with(
	impression.transition,
	round(k/n, 3)*100
)




gs_editor.counts = grouped_users[
	gs_editor==1,
	list(
		users = length(user_id)
	),
	list(
		group,
		simple_cta_type
	)
]

gs_editor.transition = merge(
	impression.counts,
	gs_editor.counts,
	by=c("group", "simple_cta_type"),
	suffixes=c(".impression", ".gs_editor")
)[,
	list(
		group,
		transition = paste(
			"[", simple_cta_type, "] --> ",
			"[GS editor]",
			sep = ""
		),
		k = users.gs_editor,
		n = users.impression
	)
]
gs_editor.transition$percentage = with(
	gs_editor.transition,
	round(k/n, 3)*100
)
gs_editor.transition





one_plus.counts = grouped_users[
	one_plus==1,
	list(
		users = length(user_id)
	),
	list(
		group,
		simple_cta_type
	)
]

one_plus.transition = merge(
	impression.counts,
	one_plus.counts,
	by=c("group", "simple_cta_type"),
	suffixes=c(".impression", ".one_plus")
)[,
	list(
		group,
		transition = paste(
			"[", simple_cta_type, "] --> ",
			"[24h 1+ editor]",
			sep = ""
		),
		k = users.one_plus,
		n = users.impression
	)
]
one_plus.transition$percentage = with(
	one_plus.transition,
	round(k/n, 3)*100
)
one_plus.transition



five_plus.counts = grouped_users[
	five_plus==1,
	list(
		users = length(user_id)
	),
	list(
		group,
		simple_cta_type
	)
]

five_plus.transition = merge(
	impression.counts,
	five_plus.counts,
	by=c("group", "simple_cta_type"),
	suffixes=c(".impression", ".five_plus")
)[,
	list(
		group,
		transition = paste(
			"[", simple_cta_type, "] --> ",
			"[24h 5+ editor]",
			sep = ""
		),
		k = users.five_plus,
		n = users.impression
	)
]
five_plus.transition$percentage = with(
	five_plus.transition,
	round(k/n, 4)*100
)
five_plus.transition




five_plus_and_gs.counts = grouped_users[
	five_plus==1 & gs_editor == 1,
	list(
		users = length(user_id)
	),
	list(
		group,
		simple_cta_type
	)
]

five_plus_and_gs.transition = merge(
	gs_editor.counts,
	five_plus_and_gs.counts,
	by=c("group", "simple_cta_type"),
	suffixes=c(".gs_editor", ".five_plus_and_gs")
)[,
	list(
		group,
		transition = paste(
			"[", simple_cta_type, "]-",
			"[GS editor] --> ",
			"[5+ editor]",
			sep = ""
		),
		k = users.five_plus_and_gs,
		n = users.gs_editor
	)
]
five_plus_and_gs.transition$perc = with(
	five_plus_and_gs.transition,
	round(k/n, 4)*100
)
five_plus_and_gs.transition
