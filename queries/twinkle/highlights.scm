; Parse errors - highlight syntax errors
(ERROR) @error

; Generic identifier - FIRST, so specific captures can override
(identifier) @variable

; PascalCase identifiers default to type highlight (e.g. Cell.new(5))
((identifier) @type
 (#match? @type "^[A-Z]"))

; Keywords by semantic role
"fn" @keyword.function

"extern" @keyword.import

"type" @keyword.type

[ "use" "as" ] @keyword.import

"pub" @keyword.modifier

[ "if" "else" "case" "cond" "for" "in" "collect" ] @keyword.control

"try" @keyword.exception

; Control flow keywords
(break_statement) @keyword.control
(continue_statement) @keyword.control

(return_statement
  "return" @keyword.return)

(defer_statement
  "defer" @keyword.control)

; Operators
[
  "="
  ":="
  "+"
  "-"
  "*"
  "/"
  "%"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "!"
  "&"
  "|"
  "^"
  "~"
  "<<"
  ">>"
] @operator

[ "and" "or" ] @keyword.operator

(range_expression operator: _ @operator)

; Boolean literals
(bool_literal) @boolean

; Numbers
(int_literal) @number
(float_literal) @number.float

; Character literals (integer code points)
(char_literal) @character

; Strings
(string_literal) @string
(string_content) @string
(escape_sequence) @string.escape

; Comments
(comment) @comment

; Types - higher priority for type contexts
(primitive_type) @type.builtin

(type_name
  (identifier) @type
  (#match? @type "^[A-Z]"))

(generic_type
  name: (type_name
    (identifier) @type
    (#match? @type "^[A-Z]")))

; Type declarations
(type_declaration
  name: (identifier) @type.definition)

; Type parameters
(type_parameter
  (identifier) @type.parameter)

; Function definitions - higher priority
(function_declaration
  name: (identifier) @function)

(extern_declaration
  module: (identifier) @module
  name: (identifier) @function)

(extern_type_declaration
  module: (identifier) @module
  name: (identifier) @type.definition)

(extern_block
  module: (identifier) @module)

(extern_signature
  name: (identifier) @function)

(extern_type_signature
  name: (identifier) @type.definition)

; Parameters
(parameter
  name: (identifier) @variable.parameter)

; Fields
(field_access
  field: (identifier) @property)

(record_field
  name: (identifier) @property)

(record_field_declaration
  name: (identifier) @property)

; Function calls - after fields so method calls take priority over property
(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (field_access
    field: (identifier) @function.method.call))

; Receiver shorthand: .method(args) in rebinding assignment
(receiver_shorthand
  method: (identifier) @function.method.call)

; Variants - high priority for constructors
(variant_expression
  variant: (identifier) @constructor)

(variant_definition
  name: (identifier) @constructor)

(shorthand_enum_pattern
  variant: (identifier) @constructor)

(qualified_enum_pattern
  variant: (identifier) @constructor)

; Wildcard pattern
(wildcard_pattern) @punctuation.special

; Module paths in use declarations — after @variable so this wins for identifiers
; Covers both `use foo.bar` and `use @stdlib`
(use_declaration
  path: (module_path) @module)
(use_declaration
  path: (module_path
    (identifier) @module))

; Destructuring import items — PascalCase = type, snake_case = function
(import_item
  name: (identifier) @type
  (#match? @type "^[A-Z]"))
(import_item
  name: (identifier) @function
  (#match? @function "^[a-z]"))

; Punctuation
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  ":"
  "."
  ","
  ";"
  "=>"
] @punctuation.delimiter

; String interpolation delimiters - after brackets so } takes priority over punctuation.bracket
(interpolation
  "${" @punctuation.special
  "}" @punctuation.special)

; Special
"?" @operator
