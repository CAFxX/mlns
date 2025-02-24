# Minimal Latency N-Sorter (MLNS)

This repo contains MLNS for small values of N, as well as the generator used to generate them.

A **N-sorter** is a circuit that, given N input values, returns them sorted.
A 2-sorter, commonly used in sorting networks, is a special case of N-sorter.

## Generator

To generate the N-sorter for a specifc value of `N`, run: `ruby mlnsgen/mlnsgen.rb <N>` (e.g. `ruby mlnsgen/mlnsgen.rb 4`).
The current algorithm is pretty dumb, so it is too slow for values of N much higher than 8.

## Generated N-Sorter

The files `nsorter_*.v` contain the generated n-sorters.

## License

[MIT](LICENSE)
