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
