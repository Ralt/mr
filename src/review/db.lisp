(in-package #:mr.review)


(pm:defprepared list-open-reviews "
select id, title, owner
from reviews
where status = 'opened'
" :plists)
