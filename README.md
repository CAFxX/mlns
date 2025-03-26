# Minimal Latency N-Sorter (MLNS)

This repo contains MLNS for small values of N, as well as the generator used to generate them.

A **N-sorter**[^k] is a circuit that, given N input values, returns them sorted.
A 2-sorter, commonly used in [sorting networks][SN], is a special case of N-sorter;
a 2-sorter implements the expression `{o0, o1} = i0 < i1 ? {i0, i1} : {i1, i0}`.

A **MLNS** is an N-sorter that aims at ensuring that the sorting happens with the smallest
possible latency. Specifically, the latency virtually does not depend on the number of inputs N[^L],
as all comparisons are done in parallel (instead of in serial stages like they are done in
sorting networks).

## Generator

To generate the N-sorter for a specifc value of `N`, run: `ruby mlnsgen/mlnsgen.rb <N>`
(e.g. `ruby mlnsgen/mlnsgen.rb 4`) or `ruby mlnsgen/mlnsgenfast.rb <N>`.

### mlnsgen

The current algorithm performs an exhaustive search (i.e. uses superlinear time), so it is
too slow for values of N much higher than 8 (and furthermore the resulting Verilog code that
implements such wide N-sorters becomes impractically large for synthesis tools to handle
efficiently).

### mlnsgenfast

This generator directly synthesizes the cases. It can be used to generate larger sorters
(but keep in mind that sorters larger than 10 are going to result in gigabytes of Verilog
code).

## Generated sorters

The files `nsorter_*.v` contain the generated n-sorters.

Just to provide a rough idea, these are the currently available generated n-sorters (for both fast and large variants) and their characteristics:

|   N |        Comparisons |      Orderings | Cells (fast)[^1] | Cells (large)[^1] |
| --: | -----------------: | -------------: | ---------------: | ----------------: |
|   2 |                  1 |              2 |              447 |               447 |
|   3 |                  3 |              6 |             1731 |              1345 |
|   4 |                  6 |             24 |             3523 |              2709 |
|   5 |                 10 |            120 |             6308 |              4533 |
|   6 |                 15 |            720 |            12330 |              6803 |
|   7 |                 21 |           5040 |            39001 |              9538 |
|   8 |                 28 |          40320 |           231810 |             12875 |
|   9 |                 36 |         362880 |          ?[^DNF] |             16388 |
|  10 |                 45 |        3628800 |          ?[^DNF] |             20485 |
|  11 |                 55 |       39916800 |          ?[^DNF] |             25036 |
|  12 |                 66 |      479001600 |          ?[^DNF] |             30040 |
|  13 |                 78 |     6227020800 |          ?[^DNF] |             35593 |
|  14 |                 91 |    87178291200 |          ?[^DNF] |             41517 |
|  15 |                105 |  1307674368000 |          ?[^DNF] |             47930 |
|  16 |                120 | 20922789888000 |          ?[^DNF] |             55768 |
| ... |                ... |            ... |              ... |               ... |
|  32 |                496 | $2.6\dot10^35$ |                ? |            232893 |
| ... |                ... |            ... |              ... |               ... |
|  64 |               2016 | $1.3\dot10^89$ |                ? |            951753 |
| ... |                ... |            ... |              ... |               ... |
| $N$ | $\dfrac{N^2-N}{2}$ |           $N!$ |                ? |                 ? |

[SiliconCompiler][SC] 0.30.0 yields the following for the smaller n-sorters:

<a href=images/nsorter_2.png><img src=images/nsorter_2.png alt="4-sorter synthesized on the skywater130 process" width="20%"></a>
<a href=images/nsorter_3.png><img src=images/nsorter_3.png alt="4-sorter synthesized on the skywater130 process" width="20%"></a>
<a href=images/nsorter_4.png><img src=images/nsorter_4.png alt="4-sorter synthesized on the skywater130 process" width="20%"></a>
<a href=images/nsorter_5.png><img src=images/nsorter_5.png alt="5-sorter synthesized on the skywater130 process" width="20%"></a>

## License

[MIT](LICENSE)

[^1]: [Yosys][Y] 0.33, `synth`; 64 bit values.
[^DNF]: Yosys was unable to complete the `synth` process due to excessive complexity.
[^2]: [SiliconCompiler][SC] 0.30.0, skywater130 process, density 50; 64 bit values.
[^3]: [SiliconCompiler][SC] 0.30.0, skywater130 process, density 40; 64 bit values.
[^L]: Specifically, the number of stages does not depend on the number of inputs, like it does in sorting networks, because there is a single comparison stage and a single selection stage regardless of the number of inputs N, and the latency of the comparison stage is constant regardless of number of inputs N. The selection stage though does contain N-way mux, so the latency of the selection stage is proportional to log2(N).
[^k]: Sometimes also called k-sorter.

[SN]: https://en.wikipedia.org/wiki/Sorting_network
[Y]: https://yosyshq.net/yosys/
[SC]: https://www.siliconcompiler.com/
