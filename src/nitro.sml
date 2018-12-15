structure Nitro = struct

datatype attr =
           IntAttr   of string*int
         | StrAttr   of string*string
         | ListAttr  of string*(string list)
         | NoValAttr of string

datatype elem = MkElem of {tag : string, attrs : attr list, body : elem list}
              | Liter of string

(*elements*)
fun panel attrs body = MkElem { tag = "div", attrs = attrs, body = body }
fun text s = Liter s
(*attributes*)
fun id v : attr = StrAttr ("id", v)
fun class v : attr = ListAttr ("class", v)

fun intercalate _ nil = nil
  | intercalate _ (h::nil) = h::nil
  | intercalate sep (h::t) = h::sep::(intercalate sep t)
fun rendAtt a =
    let val (name,v) = case a of
                           IntAttr(name,v) => (name,Int.toString(v))
                         | StrAttr(name,v) => (name,v)
                         | ListAttr(name,v) => (name,String.concat (intercalate " " v))
                         | NoValAttr name => (name,"")
    in case v of
           "" => name
         | v => name ^ "=\"" ^ v ^ "\"" end
fun render (MkElem{tag,attrs,body}) =
    "<" ^ tag ^ " " ^ (String.concat (intercalate " " (map rendAtt attrs))) ^ ">"
    ^ (String.concat (map render body)) ^ "</" ^ tag ^ ">"
  | render (Liter str) = str

end

structure Test = struct

fun main(p,a) =
    let open Nitro
        val elem = panel [class ["foo", "bar"], id "foo"] [text "div body"]
    in print (render elem); print "\n"; 0 end

end

val _ = Test.main("test",[])
