SELECT
    DATE_TRUNC('month', tr_h.pickup_datetime_ts)::DATE AS month,
    tr_h.taxi_type,
    COUNT(1) AS trips_cnt,
    ROUND(SUM(COALESCE(y_tr_s.tip_amount, g_tr_s.tip_amount)), 2) AS tips_amt,
    ROUND(DIV0(tips_amt, trips_cnt), 2) AS avg_tip_amount,
    ROUND(SUM(tr_h.total_amount), 2) AS total_amt,
    ROUND(DIV0(tips_amt, total_amt), 2) AS tips_share
FROM
    {{ ref('trips_to_pickup_locations_link') }} AS pu_lnk
LEFT JOIN {{ ref('hub_trips') }} AS tr_h ON
    pu_lnk.hk_trip = tr_h.hk_trip
LEFT JOIN {{ ref('trips_yellow_sat_v1') }} AS y_tr_s ON
    tr_h.hk_trip = y_tr_s.hk_trip
LEFT JOIN {{ ref('trips_green_sat_v1') }} AS g_tr_s ON
    tr_h.hk_trip = g_tr_s.hk_trip
WHERE
    1 = 1
    AND pu_lnk.rsrc NOT IN ('ERROR', 'SYSTEM')
    AND COALESCE(y_tr_s.is_current, g_tr_s.is_current)
    AND tr_h.pickup_datetime_ts >= '2022-01-01'
GROUP BY
    month,
    taxi_type
ORDER BY
    month DESC,
    taxi_type DESC
