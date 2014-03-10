SELECT
    DATE(LEFT(rev_timestamp, 8)) AS day,
    COUNT(rev_id) AS edits
FROM change_tag
INNER JOIN revision ON
    ct_rev_id = rev_id AND
    ct_tag = "gettingstarted edit"
GROUP BY 1;
