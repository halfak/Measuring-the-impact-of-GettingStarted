SELECT
    wiki AS wiki_db,
    event_userId AS user_id,
    COUNT(id) AS impressions,
    event_action AS action,
    event_ctaType AS cta_type,
    event_isEditable AS is_editable,
    event_pageNS AS page_namespace
FROM GettingStartedRedirectImpression_7355552
GROUP BY 1,2;
