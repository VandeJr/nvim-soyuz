(function_declaration
  name: (identifier) @definition.function)

(class_declaration
  name: (type_identifier) @definition.type)

(interface_declaration
  name: (type_identifier) @definition.type)

(record_declaration
  name: (type_identifier) @definition.type)

(enum_declaration
  name: (type_identifier) @definition.type)

(val_declaration
  name: (identifier) @definition.variable)

(var_declaration
  name: (identifier) @definition.variable)

(const_declaration
  name: (identifier) @definition.constant)

; Parâmetros de função
(parameter_list
  (pattern (identifier) @definition.parameter))

(parameter_list
  (pattern (typed_pattern pattern: (pattern (identifier) @definition.parameter))))
