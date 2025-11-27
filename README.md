# ReScript + SolidJS Example

This project demonstrates that **ReScript can be used with SolidJS** easily! It showcases:

- ✅ ReScript 11 with custom JSX module support
- ✅ SolidJS reactive primitives (signals, effects, memos)
- ✅ Fine-grained reactivity working correctly
- ✅ Type-safe component props
- ✅ Vite for development and building

## Screenshot

![ReScript + SolidJS Example](https://github.com/user-attachments/assets/9ce6da73-f785-461d-909f-a8fe000e5dad)

## Getting Started

### Prerequisites

- Node.js 18+
- npm or yarn

### Installation

```bash
npm install
```

### Development

Run the ReScript compiler in watch mode:

```bash
npm run res:dev
```

In a separate terminal, start the Vite dev server:

```bash
npm run dev
```

Open http://localhost:5173 to see the app.

### Build

```bash
npm run build
```

## How It Works

### ReScript Configuration

The `rescript.json` is configured to use a custom `Solid` JSX module with preserve mode:

```json
{
  "jsx": {
    "version": 4,
    "module": "Solid",
    "preserve": true
  }
}
```

### SolidJS Bindings

The `src/Solid.res` file provides ReScript bindings for SolidJS primitives:

- **Signals**: `createSignal` for reactive state
- **Effects**: `createEffect` for side effects
- **Memos**: `createMemo` for derived values
- **Control Flow**: `Show`, `For`, `Switch`, `Match` components

### Creating Components

Components are defined using the `@jsx.component` attribute:

```rescript
open Solid

@jsx.component
let make = (~initialCount: int=0, ()) => {
  let (count, setCount) = createSignal(initialCount)

  let increment = _ => {
    setCount(prev => prev + 1)
  }

  <div>
    <p>{string("Count: ")}{reactive(count)}</p>
    <button onClick={increment}>{string("+")}</button>
  </div>
}
```

### Reactivity

For reactive values in JSX, use the `reactive` helper to pass the accessor directly:

```rescript
// ❌ This won't be reactive (value is evaluated once)
{int(count())}

// ✅ This is reactive (accessor is passed as a function)
{reactive(count)}
```

## Project Structure

```
├── src/
│   ├── Solid.res       # SolidJS bindings
│   ├── Counter.res     # Counter component example
│   ├── App.res         # Main App component
│   └── Index.res       # Entry point
├── index.html          # HTML template
├── rescript.json       # ReScript configuration
├── vite.config.js      # Vite configuration
└── package.json        # Dependencies
```

## License

MIT