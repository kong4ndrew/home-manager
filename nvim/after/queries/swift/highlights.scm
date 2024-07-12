;; extends

; e.g. .init(color: ->darkBlue<-, ...), flagTapped(->number<-),
; countries[->number<-]
(value_argument
  (simple_identifier) @variable.identifier)

; ex. Text("Score: \(->score<-)/\(->counter<-)")
; Also, you don't need the `value:` in `interpolated_expression value:
; (simple_identifier)`
(interpolated_expression
  (simple_identifier) @variable.identifier)

; ex. ->counter<- += 1, ->correctOrNot<- = "Correct"
(directly_assignable_expression
  (simple_identifier) @variable.identifier)

; ex. ->showingAlert<-.toggle()
; Notice that parentheses surround the whole node AND predicate!
((navigation_expression
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; ex. Gradient. ->Stop<-.init(...)
((navigation_expression
   (navigation_suffix
     (simple_identifier) @type)) (#match? @type "^[A-Z]"))

; ex. ->number<- == ->correctAnswer<-
(equality_expression
  (simple_identifier) @variable.identifier)

; ex. get { ->value<- }
(statements
  (simple_identifier) @variable.identifier)

(ternary_expression
  (simple_identifier) @variable.identifier)

; ex. init(...) { self.firstOnly = firstOnly }
(assignment
  (simple_identifier) @variable.identifier) 

; ex. style(->.center<-) needs to be green?
(prefix_expression
  (simple_identifier) @variable.member)

; ex. Button {...} ->label:<- { Image(countries[number])}
(call_expression
  (call_suffix
    (simple_identifier) @parameter
    (lambda_literal)))

; ex. protocol Container { ->associatedtype<- Item}
(protocol_body
  (associatedtype_declaration) @keyword)

; ex. Color.init(->red<-: 1/255...)
(value_argument_label
  (simple_identifier) @parameter)

; ex. struct ContentView: View {
(class_declaration
  (type_identifier) @type.project) 

; ex. get { Bool.random() ? ->Cat()<- : nil }, ->ZStack<- {...}
((call_expression
   (simple_identifier) @type) (#match? @type "^[A-Z]"))

; ex. func ->style<-(_ alignment: Alignment) {...}
(function_declaration
  (simple_identifier) @function.member)

; ex. protocol Container { mutating func ->add<-(_ item: Item) }
(protocol_function_declaration
  (simple_identifier) @function.member)

; ex. enum Edge { case ->top,<- ->bottom,<- ...}
(enum_entry
  (simple_identifier) @variable.member)

; ex. let tuple = (->first:<- 0, second: 1)
(tuple_expression
  (simple_identifier) @parameter)

; ex. buildExpression(_ expression: Smoothie) -> [Smoothie] { [->expression<-]
; }
((array_literal
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; ex. ->components<- ?? []
((nil_coalescing_expression
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; ex. { ->$0<- * 2 }, { $0 / 2 }, { 2 * $0 }, { $0 +/- 1}
; Notice that there are two escapes in the regex! This is because TS is
; escaping vim's escape of $ (and d).
((lambda_literal
   (statements
     (simple_identifier) @variable.builtin))
 (#match? @variable.builtin "^\\$\\d+$"))
((lambda_literal
   (statements
     (multiplicative_expression
       (simple_identifier) @variable.builtin)))
 (#match? @variable.builtin "^\\$\\d+$"))
((lambda_literal
   (statements
     (additive_expression
       (simple_identifier) @variable.builtin)))
 (#match? @variable.builtin "^\\$\\d+$"))

; ex. [1, 2, 3].compactMap { String(->$0<-) }
((value_arguments
   (value_argument
     (simple_identifier) @variable.builtin))
 (#match? @variable.builtin "\\$\\d+$"))

; ex. ->super.<-init(...)
(super_expression) @keyword

; ex. guard let ->cat<- = cat else { return }
((guard_statement
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; ex. switch ->lengthFromUnit<- {...}
((switch_statement
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; ex. case "yd": baseUnit = ->length<- * 3
((multiplicative_expression
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))
((additive_expression
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; ex. return ->sum<-
((control_transfer_statement
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; ->isHuman<- && ->isAlive<-
((conjunction_expression
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; case ->.legal:<- 
; This highlights both the dot and identifier. Seems like there's no way to
; capture only the dot?
((switch_pattern
   (pattern
     (simple_identifier)) @variable.member)
 (#match? @variable.member "^\\..*$"))

; case ->age<- where age < 12:
((switch_pattern
   (pattern
     (simple_identifier)) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; case age where ->age<- < 12:
((comparison_expression
   (simple_identifier) @variable.identifier)
 (#match? @variable.identifier "^[a-z_]"))

; case mastiff(->droolRating<-: Int, ->weight<-: Int)
(enum_type_parameters
  (simple_identifier) @parameter)
