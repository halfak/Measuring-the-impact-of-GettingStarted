SELECT
  DATABASE() AS wiki_db,
  user_id,
  user_registration,
  COUNT(rev_id) AS day_revisions,
  COUNT(gs.ct_rev_id) AS gs_day_revisions,
  IF(bot_group.ug_user IS NOT NULL, "bot",
    IF(proxy.log_id IS NOT NULL, "proxy",
    IF(autocreated.log_id IS NOT NULL, "auto",
        "self"))) AS registration_type
FROM user
LEFT JOIN revision ON 
    user_id = rev_user AND
    rev_timestamp <= DATE_FORMAT(DATE_ADD(user_registration, INTERVAL 1 DAY), "%Y%m%d%H%i%S")
LEFT JOIN change_tag gs ON
    rev_id = ct_rev_id AND
    ct_tag = "gettingstarted edit"
LEFT JOIN logging autocreated ON /* Users who are autocreated */
  autocreated.log_user = user_id AND
  autocreated.log_type = "newusers" AND
  autocreated.log_action = "autocreate"
LEFT JOIN logging proxy ON /* Users who were registered by another user */
  proxy.log_title = REPLACE(user_name, " ", "_") AND
  proxy.log_type = "newusers" AND
  proxy.log_action = "create2"
LEFT JOIN user_groups bot_group ON
    ug_user = user_id AND
    ug_group = "bot"
WHERE user_registration >= "20140211174919"
GROUP BY 1,2;
