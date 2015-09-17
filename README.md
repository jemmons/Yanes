# Yanes
Yet Another Network um… Encoding ah… Solution?

## About
Yanes is a JSON library for Swift. It's written with the following principals in mind:

* Safety — Yanes likes types and thinks JSON is a mess. So it sets about organizing everything using sum types (enums) and strongly-typed collections.
* Convenience doesn't matter — Yanes tries to be concise and expressive whenever possible; but never at the expense of safety. Yanes assumes JSON is an interop technology living in the fringes of your glue code. As such, it thinks technical correctness and the elimination of ambiguity is more important than being pretty.
* Performance doesn't matter — Yanes doesn't even try to be fast. It uses stock `NSJSONSerialization` under the covers and only gets slower from there. Again, this assumes JSON gets used as a bridge that's crossed only rarely. If you're using it in a tight loop or have gigantic datasets, you will be disappointed (and are probably using JSON wrong).
* Objects only at the top level — Arrays are for users. And users are losers.

## Known Issues
`NSJSONSerialization` doesn't give Yanes the type information it needs to distinguish between `Bool`s, `Int`s, and `Doubles`s. They're all just numbers to Yanes. So, while it conflicts with our principals of *safety* above, values of these types will be coersed into the type you request.