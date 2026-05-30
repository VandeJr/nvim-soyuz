; Palavras-chave
[
  "val"
  "var"
  "const"
  "fn"
  "return"
  "weak"
  "pub"
  "impl"
  "record"
  "class"
  "interface"
  "enum"
  "if"
  "else"
  "match"
  "for"
  "while"
  "loop"
  "break"
  "continue"
  "in"
  "import"
  "from"
  "as"
  "when"
  "extern"
  "extend"
  "task"
  "select"
  "default"
] @keyword

(self) @keyword

; Construtores built-in
((type_identifier) @keyword.builtin (#match? @keyword.builtin "^(Ok|Err|Some|None)$"))
((identifier) @keyword.builtin (#match? @keyword.builtin "^(Ok|Err|Some|None)$"))

; Tipos primitivos
(primitive_type) @type.builtin

; Literais
(integer) @number
(float)   @number.float
(string)  @string
(boolean) @boolean
(none)    @constant.builtin

; Comentários
(comment) @comment

; Identificadores
(type_identifier) @type
(function_declaration name: (identifier)) @function
(extern_declaration name: (identifier)) @function
(call_expression function: (identifier)) @function.call
(call_expression function: (member_expression member: (identifier))) @function.method.call
(identifier) @variable

; Operadores
["->" "=>" "|>" "|?>" "~>" "~?>" "?." "?:" ".." "..="] @operator
["+" "-" "*" "/" "%" "==" "!=" "<" ">" "<=" ">=" "&&" "||" "!" "&" "|" "^" "<<" ">>"] @operator
["="] @operator

; Delimitadores
["(" ")" "[" "]" "{" "}" "," "." ":" ";"] @punctuation.delimiter
