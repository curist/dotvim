[
  (appexpr ["[" "("]) ; Applications.
  (atom ["[" "("]) ; Lists and tuples.
  (program (moduledecl "{")) ; Braced module declarations.
  (funbody)
  (block)
  (handlerexpr)
  (opclausex)
] @indent.begin

[
  (typedecl
    [(typeid) (opdecls)]) ; Avoid matching single-operation effects.
  (externdecl)
  (matchexpr)
  (matchrule)

  ; For ifexprs, branches (once they exist) will contain blocks if they're
  ; indented so we just need to make sure the initial indent happens when we're
  ; creating them.
  "then"
  "else"
] @indent.begin

(matchrule "->" @indent.begin)

; Handling for error recovery.
(ERROR "fun") @indent.begin
(ERROR "match") @indent.begin
(ERROR "->" @indent.begin)

; Don't outdent on function parameter declarations.
(atom ")" @indent.end)

[
  "]"
  "}"
] @indent.end
