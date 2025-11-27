/* SolidJS bindings for ReScript */

/* Re-export element type from Jsx module for compatibility */
type element = Jsx.element
type component<'props> = Jsx.component<'props>
type componentLike<'props, 'return> = Jsx.componentLike<'props, 'return>

/* JSX Runtime - needed for ReScript's JSX transform */
@module("solid-js/h/jsx-runtime")
external jsx: (component<'props>, 'props) => element = "jsx"

@module("solid-js/h/jsx-runtime")
external jsxs: (component<'props>, 'props) => element = "jsxs"

@module("solid-js/h/jsx-runtime")
external jsxKeyed: (component<'props>, 'props, ~key: string=?, @ignore unit) => element = "jsx"

/* Fragment: provide a value for typing */
type fragmentProps = {children?: element}
let jsxFragment: component<fragmentProps> = props => {
  switch props.children {
  | Some(c) => c
  | None => Jsx.null
  }
}

/* Solid-specific DOM props */
type style = JsxDOMStyle.t
type domRef
type classList = dict<bool>

type domProps = {
  ...JsxDOM.domProps,
  class?: string,
  classList?: classList,
  textContent?: string,
  innerHTML?: string,
}

/* Elements module for lowercase JSX elements */
module Elements = {
  type props = domProps

  @module("solid-js/h/jsx-runtime")
  external jsx: (string, props) => element = "jsx"

  @module("solid-js/h/jsx-runtime")
  external jsxs: (string, props) => element = "jsxs"

  @module("solid-js/h/jsx-runtime")
  external jsxKeyed: (string, props, ~key: string=?, @ignore unit) => element = "jsx"

  @module("solid-js/h/jsx-runtime")
  external jsxsKeyed: (string, props, ~key: string=?, @ignore unit) => element = "jsxs"

  /* Required identity used by the transform to disambiguate lower-case elements */
  external someElement: element => option<element> = "%identity"
}

/* Core Solid.js primitives */

/* Signals */
type accessor<'a> = unit => 'a
type setter<'a> = ('a => 'a) => unit
type signal<'a> = (accessor<'a>, setter<'a>)

@module("solid-js")
external createSignal: 'a => signal<'a> = "createSignal"

@module("solid-js")
external createSignalWithOptions: ('a, ~options: {..}=?, unit) => signal<'a> = "createSignal"

/* Effects */
@module("solid-js")
external createEffect: (unit => unit) => unit = "createEffect"

@module("solid-js")
external createEffectWithValue: (unit => 'a) => 'a = "createEffect"

/* Memos */
@module("solid-js")
external createMemo: (unit => 'a) => accessor<'a> = "createMemo"

@module("solid-js")
external createMemoWithPrev: ((~prev: 'a=?) => 'a) => accessor<'a> = "createMemo"

/* Resources */
type resource<'a> = accessor<option<'a>>
type resourceActions<'a> = {"mutate": option<'a> => unit, "refetch": unit => promise<'a>}

@module("solid-js")
external createResource: (unit => promise<'a>) => (resource<'a>, resourceActions<'a>) =
  "createResource"

/* Context */
type context<'a>

@module("solid-js")
external createContext: 'a => context<'a> = "createContext"

@module("solid-js")
external useContext: context<'a> => 'a = "useContext"

/* Component lifecycle */
@module("solid-js")
external onMount: (unit => unit) => unit = "onMount"

@module("solid-js")
external onCleanup: (unit => unit) => unit = "onCleanup"

@module("solid-js")
external onError: (Js.Exn.t => unit) => unit = "onError"

/* Reactive utilities */
@module("solid-js")
external batch: (unit => 'a) => 'a = "batch"

@module("solid-js")
external untrack: (unit => 'a) => 'a = "untrack"

@module("solid-js")
external createRoot: ((unit => unit) => 'a) => 'a = "createRoot"

/* Helper utilities */
@module("solid-js")
external createUniqueId: unit => string = "createUniqueId"

@module("solid-js")
external children: (unit => 'a) => accessor<'a> = "children"

@module("solid-js")
external mergeProps: ('a, 'b) => 'c = "mergeProps"

@module("solid-js")
external splitProps: ('props, array<string>) => ('a, 'b) = "splitProps"

/* Helper functions for element creation */
external array: array<element> => element = "%identity"
@val external null: element = "null"
external float: float => element = "%identity"
external int: int => element = "%identity"
external string: string => element = "%identity"

/* Helper to make accessor reactive in JSX - pass accessor directly without calling it */
external reactive: accessor<'a> => element = "%identity"

/* SolidJS Control Flow Components */

module Show = {
  type props<'a> = {
    @as("when") when_: 'a,
    @as("fallback") fallback_?: element,
    children: 'a => element,
  }
  @module("solid-js")
  external make: Jsx.component<props<'a>> = "Show"
}

module For = {
  type props<'a> = {
    @as("each") each_: array<'a>,
    @as("fallback") fallback_?: element,
    children: ('a, accessor<int>) => element,
  }
  @module("solid-js")
  external make: Jsx.component<props<'a>> = "For"
}

module Switch = {
  type props = {
    @as("fallback") fallback_?: element,
    children: element,
  }
  @module("solid-js")
  external make: Jsx.component<props> = "Switch"
}

module Match = {
  type props<'a> = {
    @as("when") when_: 'a,
    children: element,
  }
  @module("solid-js")
  external make: Jsx.component<props<'a>> = "Match"
}

module ErrorBoundary = {
  type props = {
    @as("fallback") fallback: (Js.Exn.t, accessor<unit => unit>) => element,
    children: element,
  }
  @module("solid-js")
  external make: Jsx.component<props> = "ErrorBoundary"
}

module Suspense = {
  type props = {
    @as("fallback") fallback_?: element,
    children: element,
  }
  @module("solid-js")
  external make: Jsx.component<props> = "Suspense"
}

/* Web module for render function */
module Web = {
  @module("solid-js/web")
  external render: (unit => element, Dom.element) => (unit => unit) = "render"
}
