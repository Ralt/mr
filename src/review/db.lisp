(in-package #:mr.review)


(pm:defprepared list-open-reviews "
select id, title, owner
from reviews
where status = 'opened'
" :plists)

(pm:defprepared get-one-review "
select r.title, u.login as owner, r.status
from reviews r
left join users u
on r.owner = u.id
where r.id = $1
" :plist)
