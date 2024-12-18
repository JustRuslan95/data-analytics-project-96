with last_paid_visits as (
    select
        visitor_id,
        MAX(visit_date) as last_paid_click_date
    from sessions s 
    where medium != 'organic'
    group by visitor_id
)

select
    lpv.visitor_id,
    lpv.last_paid_click_date as visit_date,
    s."source" as utm_source,
    s.medium as utm_medium,
    s.campaign as utm_campaign,
    l.lead_id,
    l.created_at,
    l.amount,
    l.closing_reason,
    l.status_id
from sessions s
inner join last_paid_visits lpv
    on
        lpv.visitor_id = s.visitor_id
        and lpv.last_paid_click_date = s.visit_date
left join leads as l
    on
        s.visitor_id = l.visitor_id
        and l.created_at >= s.visit_date
where s.medium != 'organic'
order by 8 desc nulls last, 2, 3, 4, 5;