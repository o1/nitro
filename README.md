Nitro DSL
=========

Nitro DSL


Demo
----

```SML
structure Test = struct

fun main(p,a) =
    let open Nitro
        nonfix div
        val elem = div [class ["foo", "bar"], id "foo", body [text "div body"]]
        val expected = "<div class=\"foo bar\" id=\"foo\">div body</div>"
        val actual = render elem
    in if actual = expected then 0 else
       raise Fail ("\nExpected: " ^ expected ^ "\n  Actual: " ^ actual ^ "\n") end

end

val _ = Test.main("test",[])
```
