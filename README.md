Nitro DSL
=========

Nitro DSL


Demo
----

```SML
structure Test = struct

fun main(p,a) =
    let open Nitro
        val elem = div [class ["foo", "bar"], id "foo", body [text "div body"]]
    in print (render elem); print "\n"; 0 end

end

val _ = Test.main("test",[])
```

```bash

$ ml-build nitro.cm
Standard ML of New Jersey v110.84 [built: Tue Dec 04 16:31:04 2018]
[scanning nitro.cm]
[library $cml/basis.cm is stable]
[library $cml/cml.cm is stable]
[library $cml-lib/smlnj-lib.cm is stable]
[parsing (nitro.cm):src/nitro.sml]
src/nitro.sml:58.1-58.29 Warning: definition not tracked by CM
[library $SMLNJ-BASIS/basis.cm is stable]
[library $SMLNJ-BASIS/(basis.cm):basis-common.cm is stable]
[compiling (nitro.cm):src/nitro.sml]
[code: 5372, data: 340, env: 1003 bytes]
[scanning 9049-export.cm]
[scanning (9049-export.cm):nitro.cm]
[parsing (9049-export.cm):9049-export.sml]
[compiling (9049-export.cm):9049-export.sml]
[code: 314, data: 34, env: 39 bytes]
<div class="foo bar" id="foo" >div body</div>

```
