(in-package #:mr)


(pm:defprepared user "select user($1)" :single)

(pm:defprepared user-create "select create_user($1)" :none)
