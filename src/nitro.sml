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

structure Main = struct

fun main(p,a) = 0

end
