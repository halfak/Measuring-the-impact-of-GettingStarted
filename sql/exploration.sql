
SELECT wiki, COUNT(*)  
FROM (
    SELECT wiki, event_userId
    FROM ServerSideAccountCreation_5487345 
    WHERE 
        timestamp BETWEEN 
            DATE_FORMAT(DATE_ADD("20140211181300", INTERVAL -14 DAY), "%Y%m%d%H%i%S") AND 
            DATE_FORMAT(DATE_ADD("20140211181300", INTERVAL 14 DAY), "%Y%m%d%H%i%S") AND
        event_isSelfMade AND 
        NOT event_displayMobile AND
        wiki IN (
            "dewiki", "elwiki", "eswiki", "fawiki", "frwiki", "fowiki", "glwiki", 
            "hewiki", "huwiki", "iswiki", "itwiki", "kowiki", "lbwiki", "mkwiki", 
            "mlwiki", "nlwiki", "plwiki", "ptwiki", "ruwiki", "simplewiki", 
            "svwiki", "viwiki", "ukwiki", "zhwiki"
        )
    GROUP BY 1,2
) AS sampled_users
GROUP BY wiki
ORDER BY COUNT(*) DESC;



