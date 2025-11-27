/* Counter component demonstrating SolidJS with ReScript */

open Solid

@jsx.component
let make = (~initialCount: int=0, ()) => {
  let (count, setCount) = createSignal(initialCount)

  let increment = _ => {
    setCount(prev => prev + 1)
  }

  let decrement = _ => {
    setCount(prev => prev - 1)
  }

  <div>
    <h2>{string("Counter Component")}</h2>
    <p>
      {string("Count: ")}
      /* Use reactive(count) instead of int(count()) to preserve SolidJS reactivity.
         The accessor must be passed as a function for fine-grained updates to work. */
      {reactive(count)}
    </p>
    <button onClick={increment}>
      {string("+")}
    </button>
    <button onClick={decrement}>
      {string("-")}
    </button>
  </div>
}
