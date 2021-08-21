# JMod
The goal is to be like the J programming language,
but with syntax level support for modular arithmetic,
and with S-expressions to make parsing easier for now.
It also requires the rank of the some operators be specified,
unlike J. For instance:

```
> 3m4
3m4

> 5m4
1m4

> 1 + 3m4
0m4

> (+ 1 [0 3m4 6m2])
(1 0m4 1m2)

> ((" / 1) + '(1m2 0m2 1m2))
0m2

> (i. 4)
[0 1 2 3]

> (+ 0m4 (i. 8))
[0m4 1m4 2m4 3m4 0m4 1m4 2m4 3m4 ]


> (i. 4m2 2)
Type error

> (:= y ($ '(2 2) (i. 4 4)))
> y
((0m4 1m4) 
 (2m4 3m4))

> ((" / 0) + y)   NB. Sum across every element (doesn't do anything)
((0m4 1m4) 
 (2m4 3m4))

> ((" / 1) + y)   NB. Sum across the first list
(1m4 1m4)

> ((" / 2) + y)   NB. Sym across the first column
(2m4 0m4)
```


First-in-class comments are created with `NB.` until the end of line.
