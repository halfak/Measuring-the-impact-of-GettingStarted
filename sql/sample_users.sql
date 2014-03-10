SET @first_deploy = "20140211181300";

/* eswiki *********************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "eswiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "eswiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* frwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "frwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "frwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* zhwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "zhwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "zhwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* ruwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "ruwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "ruwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* dewiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "dewiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "dewiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* ptwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "ptwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "ptwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* itwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "itwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "itwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* fawiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "fawiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "fawiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* nlwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "nlwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "nlwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* plwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "plwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "plwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* viwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "viwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "viwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* svwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "svwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "svwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* ukwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "ukwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "ukwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* kowiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "kowiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "kowiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* huwiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "huwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "huwiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)

UNION /* hewiki ***************************************************************/

(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "before deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "hewiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL -1 SECOND), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
)UNION(
    SELECT DISTINCT wiki, event_userId AS user_id, timestamp AS user_registration, "after deployment" AS bucket
    FROM ServerSideAccountCreation_5487345
    WHERE wiki = "hewiki" AND event_isSelfMade AND NOT event_displayMobile AND timestamp BETWEEN @first_deploy AND
            DATE_FORMAT(DATE_ADD(@first_deploy, INTERVAL 14 DAY), "%Y%m%d%H%i%S")
    ORDER BY RAND()
    LIMIT 500
);
