SELECT
    wiki AS wiki_db,
    event_userId AS user_id,
    timestamp AS user_registration,
    event_returnTo AS return_to,
    event_returnToQuery AS return_query,
    event_displayMobile AS mobile
FROM ServerSideAccountCreation_5487345
WHERE
    event_isSelfMade AND 
    timestamp >= "20140206"
GROUP BY 1,2;
