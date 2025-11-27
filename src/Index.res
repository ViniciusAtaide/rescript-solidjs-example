/* Entry point for the application */

@val @scope("document")
external getElementById: string => Js.Nullable.t<Dom.element> = "getElementById"

switch getElementById("root")->Js.Nullable.toOption {
| Some(root) => {
    let _ = Solid.Web.render(() => <App />, root)
  }
| None => Js.Console.error("Root element not found")
}
