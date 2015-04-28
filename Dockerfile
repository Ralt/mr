FROM dparnell/sbcl-1.2.5

EXPOSE 4242 4005

WORKDIR /root/common-lisp/mr

CMD make && ./dist/mr
