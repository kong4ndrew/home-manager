;; extends

; VARIABLE IDENTIFIERS--------------------------------------------------------

; [Guess The Flag] ex. .init(color: ->darkBlue<-, ...)
; [Guess The Flag] flagTapped(->number<-)
((value_argument
  value: (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_$]"))

; [Guess The Flag] ex. ->countries<-[number]
; Note that if a single capture doesn't activate its specified predicate, the
; entire capture is invalid. That's why 'countries' in countries[number] will
; be captured as @variable.identifier but 'flagTapped' in flagTapped(number)
; won't because its @_call_suffix '(number)' matched '^\\(.*\\)$', invalidating
; flagTapped being captured as a @variable.identifier, instead leaving
; flagTapped to remain captured as a @function.call.
((call_expression
  (simple_identifier) @variable.identifier
  (call_suffix) @_call_suffix)
  (#match? @variable.identifier "^[a-z_]")
  (#not-match? @_call_suffix "^\\(.*\\)$"))

; [Guess The Flag] ex. Text("Score: \(->score<-)/\(->counter<-)")
(interpolated_expression
  value: (simple_identifier) @variable.identifier)

; [Guess The Flag] ex. ->counter<- += 1, ->correctOrNot<- = "Correct"
(directly_assignable_expression
  (simple_identifier) @variable.identifier)

; [Guess The Flag] ex. ->showingAlert<-.toggle()
; Notice that parentheses surround the whole node AND predicate!
((navigation_expression
  target: (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))

; [Guess The Flag] ex. ->number<- == ->correctAnswer<-
(equality_expression
  (simple_identifier) @variable.identifier)

; ex. [iOSPlayground] get { ->value<- }
((statements
  (simple_identifier) @variable.identifier)
  (#has-ancestor? @variable.identifier computed_getter computed_setter))

; [iOSPlayground] set { value = ->firstOnly<- ? ->newValue<-.capitalized :
; ->newValue<-.uppercased() }
(ternary_expression
  (simple_identifier) @variable.identifier)

; ex. [iOSPlayground] init(...) { self.firstOnly = ->firstOnly<- }
(assignment
  result: (simple_identifier) @variable.identifier) 

; [iOSPlayground] ex. buildExpression(_ expression: Smoothie) -> [Smoothie] {
; [->expression<-] }
((array_literal
  (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))

; [iOSPlayground] ex. ->components<- ?? []
(nil_coalescing_expression
  (simple_identifier) @variable.identifier
  (#match? @variable.identifier "^[a-z_]"))

; [iOSPlayground] ex. return ->sum<-
((control_transfer_statement
  result: (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))

; [iOSPlayground] ex. guard let ->cat<- = ->cat<- else { return } Labels
; matter! Labeling (simple_identifier) with bound_identifier will cause the
; second cat to not be highlighted and only the bound_identifier cat to be
; highlighted
((guard_statement
  (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))

; [challenge1.1] ex. switch ->lengthFromUnit<- {...}
((switch_statement
  expr: (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))

; [challenge1.1] ex. case "yd": baseUnit = ->length<- * 3
((multiplicative_expression
  (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))
((additive_expression
  (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))

; [hwsReview] ex. case ->age<- where age < 12:
; Slightly redundant with previous query but somehow works perfectly?
; @variable.identifier seems to have higher priority than @variable.member
((switch_pattern
  (pattern
    (simple_identifier)) @variable.identifier)
    (#match? @variable.identifier "^[a-z_]"))

; [hwsReview] ex. case age where ->age<- < 12:
((comparison_expression
  (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))

; [hwsReview] ex. ->isHuman<- && ->isAlive<-
((conjunction_expression
  (simple_identifier) @variable.identifier)
  (#match? @variable.identifier "^[a-z_]"))

; VARIABLE MEMBERS------------------------------------------------------------

; [iOSPlayground] ex. enum Edge { case ->top,<- ->bottom,<- ...}
(enum_entry
  (simple_identifier) @variable.member)

; ex. [iOSPlayground] style(->.center<-) (implied type)
((prefix_expression
  (simple_identifier) @variable.member)
  (#match? @variable.member "^[a-z_]"))

; [hwsReview] ex. case ->.legal:<- 
((switch_pattern
  (pattern
    (simple_identifier) @variable.member))
    (#match? @variable.member "^[a-z_]"))

; BUILT-IN VARIABLES----------------------------------------------------------

; [iOSPlayground] ex. { ->$0<- * 2 }, { $0 / 2 }, { 2 * $0 }, { $0 +/- 1}
; Notice that there are two escapes in the regex. This is because TS must
; escape vim's escape of $ (and d).
((simple_identifier) @variable.builtin
  (#match? @variable.builtin "^\\$\\d+$")
  (#has-ancestor? @variable.builtin lambda_literal))

((simple_identifier) @variable.builtin
  (#match? @variable.builtin "newValue|oldValue"))

; FUNCTIONS-------------------------------------------------------------------

; [iOSPlayground] ex. func ->style<-(_ alignment: Alignment) {...}
(function_declaration
  (simple_identifier) @function.member)

; [iOSPlayground] ex. protocol Container { mutating func ->add<-(_ item: Item) }
(protocol_function_declaration
  (simple_identifier) @function.member)

; PARAMETERS------------------------------------------------------------------

; [Guess The Flag] ex. Color.init(->red<-: 1/255...)
(value_argument_label
  (simple_identifier) @parameter)

; [Guess The Flag] ex. Button {...} ->label:<- { Image(countries[number])}
((call_suffix
  name: (simple_identifier) @parameter)
  (#has-ancestor? @parameter call_suffix call_expression lambda_literal))

; [iOSPlayground] ex. let tuple = (->first:<- 0, second: 1)
(tuple_expression
  (simple_identifier) @parameter)

; [hwsReview] ex. case mastiff(->droolRating<-: Int, ->weight<-: Int)
(enum_type_parameters
  (simple_identifier) @parameter)

; TYPES ----------------------------------------------------------------------

; [Guess The Flag] ex. Gradient. ->Stop<-.init(...)
(((simple_identifier) @type) @_parent
  (#match? @type "^[A-Z]")
  (#has-parent? @_parent navigation_suffix navigation_expression))

; [iOSPlayground] ex. get { Bool.random() ? ->Cat()<- : nil }, ->ZStack<- {...}
((call_expression
  (simple_identifier) @type)
  (#match? @type "^[A-Z]"))

; [Guess The Flag] ex. struct ->ContentView<-: View {
(class_declaration
  (type_identifier) @type.project) 

; KEYWORDS--------------------------------------------------------------------

; [iOSPlayground] ex. protocol Container { ->associatedtype<- Item}
(protocol_body
  (associatedtype_declaration) @keyword)

; [iOSPlayground] ex. ->super.<-init(...)
(super_expression) @keyword

; [hwsReview] ex. if ->case<- let syntax
(if_statement
  "case" @keyword)

; ex. ->self<-.red or print(->self<-)
(self_expression) @keyword

; TODO: if case let syntax-----------------------------------------------------------------------
; [hwsReview] ex. if case let Puppy.mastiff(droolRating, weight) = ->fido<- {
(if_statement
  condition: (simple_identifier) @variable.identifier)

; [hwsReview] ex. if case let Puppy.mastiff(->droolRating<-, ->weight<-) = fido
((pattern
  (simple_identifier) @parameter)
  (#has-ancestor? @parameter if_statement))

; [hwsReview] ex. if case Puppy.mastiff(let ->droolRating<-, let ->weight<-)
; When preceded by let, make the parameters colored to be like a let bound
; variable. #not-has-parent? @parameter value_binding_pattern isn't working
((pattern
  bound_identifier: (simple_identifier) @variable)
  (#has-ancestor? @variable if_statement))

; [hwsReview] ex. if case let Puppy->.mastiff<-(droolRating, weight) = fido {...
; Fix: it's getting captured as variable.identifier 
;  Not sure if there's a way to consistently capture enum cases with associated
; values as variable members so for the sake of consistency, linking it to
; functions
((if_statement
   (user_type
     (type_identifier))
  (simple_identifier) @function.call)
(#match? @function.call "^[a-z_]"))
;(#has-ancestor? @function.member user_type))

; [hwsReview] ex. let fido = Puppy. ->mastiff<-(droolRating: 8, weight: 10)
;((class_declaration
;  (_)
;  (_
;  (enum_entry
;  name: (simple_identifier) @_case)))
;(_)*
;(property_declaration
;  (_)
;  (_
;    (_))
;  (_
;    (_
;      (_)
;  (navigation_suffix
;    suffix: (simple_identifier) @variable.member))))
;    (#eq? @variable.member @_case))
