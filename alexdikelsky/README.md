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

> (+ 1 3m4)
0m4

> (+ 1 [0 3m4 6m2])
[1 0m4 1m2]

> (/ + 0 '(1m2 0m2 1m2)))
0m2

> (i. 4)
[0 1 2 3]

> (+ 0m4 (i. 8))
[0m4 1m4 2m4 3m4 0m4 1m4 2m4 3m4 ]

```

Lambdas are supported

```
> ((λ (x) (+ x 3)) [4 5])
[7 8]

> (((λ (f g) (λ (x) (f (g x)))) (λ (x) (/ + 0 x)) |:) [[3 4] [5 6]])
[7 11]
```

