# Minimal Latency N-Sorter (MLNS)

This repo contains MLNS for small values of N, as well as the generator used to generate them.

A **N-sorter** is a circuit that, given N input values, returns them sorted.
A 2-sorter, commonly used in [sorting networks][SN], is a special case of N-sorter.

A **MLNS** is an N-sorter that aims at ensuring that the sorting happens with the smallest
possible latency. Specifically, the latency virtually does not depend on the number of inputs N,
as all comparisons are done in parallel (instead of in serial stages like they are done in
sorting networks).

## Generator

To generate the N-sorter for a specifc value of `N`, run: `ruby mlnsgen/mlnsgen.rb <N>`
(e.g. `ruby mlnsgen/mlnsgen.rb 4`).
The current algorithm is pretty dumb (it performs an exhaustive search, i.e. uses superlinear
time), so it is too slow for values of N much higher than 8 (and furthermore the resulting
Verilog code that implements such wide N-sorters becomes impractically large for synthesis
tools to handle efficiently).

## Generated sorters

The files `nsorter_*.v` contain the generated n-sorters.

Just to provide a rough idea, these are the currently available generated n-sorters and their characteristics:

|   N | Comparisons | Orderings | Gates[^1] | Area[^2] µm² |
| --: | ----------: | --------: | --------: | -----------: |
|   2 |           1 |         2 |       447 |       6906.6 |
|   3 |           3 |         6 |      1736 |      14589.0 |
|   4 |           6 |        24 |      3543 |      27781.6 |
|   5 |          10 |       120 |      6366 |            ? |
|   6 |          15 |       720 |     12551 |            ? |
|   7 |          21 |      5040 |     41387 |            ? |
|   8 |          28 |     40320 |    250448 |            ? |
|   9 |          36 |    362880 |         ? |            ? |

[SiliconCompiler][SC] yields the following for the 4-sorter:

<a href=nsorter_2.png><img src=nsorter_2.png alt="4-sorter synthesized on the skywater130 process" width="20%" align=center></a>
<a href=nsorter_3.png><img src=nsorter_3.png alt="4-sorter synthesized on the skywater130 process" width="20%" align=center></a>
<a href=nsorter_4.png><img src=nsorter_4.png alt="4-sorter synthesized on the skywater130 process" width="20%" align=center></a>

## License

[MIT](LICENSE)

[^1]: [Yosys][Y] 0.33, `synth`; 64 bit values
[^2]: [SiliconCompiler][SC] 0.30.0, skywater130 process, density 50; 64 bit values

[SN]: https://en.wikipedia.org/wiki/Sorting_network
[Y]: https://yosyshq.net/yosys/
[SC]: https://www.siliconcompiler.com/
