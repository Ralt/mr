(in-package #:mr.user)


(pm:defprepared user-by-login "select user_by_login($1)" :single)

(pm:defprepared user-create "select create_user($1)" :single)
