structure Nitro = struct

datatype attr =
           IntAtt   of string*int
         | StrAtt   of string*string
         | ListAtt  of string*(string list)
         | NoValAtt of string

datatype elem = MkElem of {tag : string, attrs : attr list, body : elem list}
              | Liter of string

fun panel attrs body = MkElem { tag = "div", attrs = attrs, body = body }

fun id v : attr = StrAtt ("id", v)
fun class v : attr = ListAtt ("class", v)
fun text s = Liter s

fun intercalate _ nil = nil
  | intercalate _ (h::nil) = h::nil
  | intercalate sep (h::t) = h::sep::(intercalate sep t)
fun rendAtt a =
    let val (name,v) = case a of
                           IntAtt(name,v) => (name,Int.toString(v))
                         | StrAtt(name,v) => (name,v)
                         | ListAtt(name,v) => (name,String.concat (intercalate " " v))
                         | NoValAtt name => (name,"")
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
