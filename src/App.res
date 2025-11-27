/* Main App component */

open Solid

@jsx.component
let make = () => {
  <div>
    <h1>{string("ReScript + SolidJS Example")}</h1>
    <p>{string("This demonstrates using SolidJS with ReScript!")}</p>
    <Counter initialCount=5 />
  </div>
}
