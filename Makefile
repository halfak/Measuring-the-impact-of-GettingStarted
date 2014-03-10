

datasets/new_user_day_edits.tsv: sql/new_user_day_edits.sql
	./query_wikis datasets/gs_wikis.tsv --query=sql/new_user_day_edits.sql> \
	datasets/new_user_day_edits.tsv
	
#datasets/new_user_returns.tsv: sql/new_user_returns.sql \
#                               gs/extract_user_return.py
#	cat sql/new_user_returns.sql | \
#	mysql -h db1047 -u research | \
#	./extract_user_return > \
#	datasets/new_user_returns.tsv
	
datasets/new_user_impressions.tsv: sql/new_user_impressions.sql
	cat sql/new_user_impressions.sql | \
	mysql -h db1047.eqiad.wmnet -u research log > \
	datasets/new_user_impressions.tsv
	
datasets/newly_registered_users.tsv: sql/newly_registered_users.sql
	cat sql/newly_registered_users.sql | \
	mysql -h db1047.eqiad.wmnet -u research log > \
	datasets/newly_registered_users.tsv

datasets/sample_users.tsv: sql/sample_users.sql
	cat sql/sample_users.sql | \
	mysql -h db1047.eqiad.wmnet -u research log > \
	datasets/sample_users.tsv

datasets/sample_user_stats.tsv: gs/new_user_stats.py \
                                datasets/sample_users.tsv
	cat datasets/sample_users.tsv | \
	./new_user_stats --defaults-file ~/.my.cnf -u research > \
	datasets/sample_user_stats.tsv
