structure Nitro = struct

datatype attr =
           IntAttr   of string*int
         | StrAttr   of string*string
         | ListAttr  of string*(string list)
         | BodyAttr  of elem list
         | NoValAttr of string
and elem = MkElem of {tag : string, attrs : attr list}
         | Liter of string

(*elements*)
fun panel attrs = MkElem {tag = "div", attrs = attrs}
fun text s = Liter s
(*attributes*)
fun id v = StrAttr ("id", v)
fun class v = ListAttr ("class", v)
fun body v = BodyAttr v

fun intercalate _ nil = nil
  | intercalate _ (h::nil) = h::nil
  | intercalate sep (h::t) = h::sep::(intercalate sep t)
fun getBody nil = nil
  | getBody ((BodyAttr x)::_) = x
  | getBody (h::t) = getBody t
fun rendAtt a =
    let val x = case a of
                    IntAttr(name,v) => SOME (name,Int.toString(v))
                  | StrAttr(name,v) => SOME (name,v)
                  | ListAttr(name,v) => SOME (name,String.concat (intercalate " " v))
                  | BodyAttr _ => NONE
                  | NoValAttr name => SOME (name,"")
    in case x of
           NONE => NONE
         | SOME (name,"") => SOME name
         | SOME (name,v) => SOME (name ^ "=\"" ^ v ^ "\"") end
val renderAttrs = String.concat o intercalate " " o map valOf o List.filter isSome o map rendAtt
fun render (MkElem {tag,attrs}) =
    let val body = String.concat (map render (getBody attrs))
        val attrs = renderAttrs attrs
    in
        "<" ^ tag ^ " " ^ attrs ^ ">" ^ body ^ "</" ^ tag ^ ">"
    end
  | render (Liter str) = str

end

structure Test = struct

fun main(p,a) =
    let open Nitro
        val elem = panel [class ["foo", "bar"], id "foo", body [text "div body"]]
    in print (render elem); print "\n"; 0 end

end

val _ = Test.main("test",[])
