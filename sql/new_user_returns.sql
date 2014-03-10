SELECT
    wiki,
    event_userId,
    event_returnTo
FROM log.ServerSideAccountCreation_5487345
WHERE event_isSelfMade
AND timestamp >= "20140211174919"
GROUP BY 1,2;
