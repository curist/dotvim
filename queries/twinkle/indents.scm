; Neovim Treesitter indentation query for Twinkle.
; Capture style here intentionally follows nvim-treesitter indents.scm.

[
  (array_literal)
  (anonymous_record_literal)
  (named_record_literal)
  (argument_list)
  (parameter_list)
  (function_expression)
  (block)
  (case_expression)
  (assignment_expression)
  (let_binding)
  (unary_expression)
  (logical_or_expression)
  (logical_and_expression)
  (bitwise_or_expression)
  (bitwise_xor_expression)
  (bitwise_and_expression)
  (equality_expression)
  (comparison_expression)
  (shift_expression)
  (additive_expression)
  (multiplicative_expression)
  (field_access)
  (index_access)
  (sum_type_def)
  (record_type_def)
] @indent.begin

; Branch points such as `else` should align with their owning `if`.
(if_expression
  "else" @indent.branch)

; Each `case` arm should realign to the pattern/variant column.
(case_arm
  pattern: (_) @indent.branch)

; Sum type variants should align with each other inside `{ ... }`.
(variant_definition) @indent.branch

; Pressing `o` after a comma in these lists should stay at arm/variant level.
(case_arms "," @indent.branch)
(variant_definition_list "," @indent.branch)

[
  ")"
  "}"
  "]"
] @indent.end

[
  ")"
  "}"
  "]"
] @indent.branch

; Let multiline literals/comments keep their own internal indentation behavior.
(string_literal) @indent.ignore
(comment) @indent.auto
