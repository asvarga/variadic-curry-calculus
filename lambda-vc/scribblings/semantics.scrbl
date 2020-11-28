#lang scribble/manual
@; -*- mode: Scribble -*-

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

@require[@for-label[lambda-vc
                    lambda-vc/base
                    racket/contract]
         scribble-math
         "math-help.rkt"]
@(use-mathjax)

@title[#:tag "sec:semantics"]{λ@subscript{vc} Semantics}
@author[(@author+email "Pierce Darragh" "pierce.darragh@gmail.com")]

Some stuff.

@section{Syntax Rules}

@tabular[#:sep @hspace[1]
(list @; Terms Table Header
      (list @bold{t ::=} "" @bold{terms:} 'cont)
      @; Rows
      (list ""
            @tt{z}
            ""
            "integer")
      (list ""
            @tt{x}
            ""
            "variable")
      (list ""
            @tt{(λ (x@superscript{*}) t)}
            ""
            "n-ary function")
      (list ""
            @tt{(λ (x@superscript{+} ...) t)}
            ""
            "variadic function")
      (list ""
            @tt{σ(t)}
            ""
            "superposition")
      (list ""
            @tt{(t@superscript{+})}
            ""
            "application")
      @; Spacing
      (list "" "" "" "")
      @; Values Table Header
      (list @bold{v ::=} "" @bold{values:} 'cont)
      @; Rows
      (list ""
            @tt{z}
            ""
            "integer value")
      (list ""
            @tt{x}
            ""
            "variable value")
      (list ""
            @tt{(λ () t)}
            ""
            "nullary function value")
      (list ""
            @tt{(λ (x) t)}
            ""
            "unary function value")
      (list ""
            @tt{(λ (x ...) t)}
            ""
            "variadic function value")
      (list ""
            @tt{σ(t)}
            ""
            "superposition value"))]

@section{Evaluation Rules}

This is the operational semantics.

@tabular[#:sep @hspace[1]
(list
  (list @$$rule-name{E-Substitute}
        @$$judgment[
          @env{@x{1} -> @v{2}} @x{1}
          @evaluates-to
          @env{} @v{2}
        ])
  (list @$$rule-name{E-Curry}
        @$$judgment[
          @func{@x{1} @space @x{2}^{+} . @t{3}}
          @evaluates-to
          @func{@x{1} . @func{@x{2}^{+} . @t{3}}}
        ])
  (list @$$rule-name{E-AppUncurry}
        @$$judgment[
          @parens{@t{1} @space @t{2} @space @t{3}^{+}}
          @evaluates-to
          @parens{@parens{@t{1} @space @t{2}} @space @t{3}^{+}}
        ])
  (list @$$rule-name{E-AppReduce1}
        @$$judgment[
          #:premise @group{
                      @t{1}
                      @evaluates-to
                      @t{1}'
          }
          #:conclusion @group{
                        @parens{@t{1} @space @t{2}}
                        @evaluates-to
                        @parens{@t{1}' @space @t{2}}
          }])
  (list @$$rule-name{E-AppReduce2}
        @$$judgment[
          #:premise @group{
                      @t{2}
                      @evaluates-to
                      @t{2}'
          }
          #:conclusion @group{
                        @parens{@v{1} @space @t{2}}
                        @evaluates-to
                        @parens{@v{1} @space @t{2}'}
          }])
  (list @$$rule-name{E-AppNull}
        @$$judgment[
          #:premise @group{
                      @t{1}
                      @evaluates-to
                      @t{1}'
          }
          #:conclusion @group{
                        @parens{@func{@space . @t{1}}}
                        @evaluates-to
                        @t{1}'
          }])
  (list @$$rule-name{E-AppUnary}
        @$$judgment[
          @parens{@func{@x{1} . @t{2}} @space @v{3}}
          @evaluates-to
          @env{@x{1} -> @v{3}} @t{2}
        ])
  (list @$$rule-name{E-AppVariadic}
        @$$judgment[
          #:premise @group{
                      @env{@x{1} -> @v{2}, @x{3} -> @v{5}} @t{4}
                      @evaluates-to*
                      @v{6}
          }
          #:conclusion @group{\small
                        @env{@x{1} -> @v{2}} @parens{@func{@x{3} @space @ellipsis . @t{4}} @space @v{5}}
                        @evaluates-to
                        @env{@x{1} -> @v{6}} @sup{@v{6} | @func{@x{3} @space @ellipsis . @t{4}}}
          }])
  (list @$$rule-name{E-AppSuperposition}
        @$$judgment[
          #:premises (list
                      @group{
                        @parens{@v{1} @space @v{3}}
                        @evaluates-to
                        @t{13}}
                      @group{
                        @parens{@v{2} @space @v{3}}
                        @evaluates-to
                        @t{23}})
          #:conclusion @group{
                        @parens{@sup{@v{1} | @v{2}} @space @v{3}}
                        @evaluates-to
                        @sup{@t{13} | @t{23}}
          }])
  (list @$$rule-name{E-SuperpositionReduce1}
        @$$judgment[
          #:premise @group{
                      @t{1}
                      @evaluates-to
                      @t{1}'
          }
          #:conclusion @group{
                        @sup{@t{1} | @t{2}}
                        @evaluates-to
                        @sup{@t{1}' | @t{2}}
          }])
  (list @$$rule-name{E-SuperpositionReduce2}
        @$$judgment[
          #:premise @group{
                      @t{2}
                      @evaluates-to
                      @t{2}'
          }
          #:conclusion @group{
                        @sup{@v{1} | @t{2}}
                        @evaluates-to
                        @sup{@v{1} | @t{2}'}
          }])
  (list @$$rule-name{E-SuperpositionReduce3}
        @$$judgment[
          @sup{@g-epsilon | @t{2}}
          @evaluates-to
          @t{2}
        ])
  (list @$$rule-name{E-SuperpositionReduce4}
        @$$judgment[
          @sup{@t{1} | @g-epsilon}
          @evaluates-to
          @t{1}
        ])
)]

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

@; End of file.