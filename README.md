<!--
Copyright (C) 2023 Mitsubishi Electric Research Laboratories (MERL)

SPDX-License-Identifier: AGPL-3.0-or-later
-->
# GNIGAN

This repository provides a MATLAB implementation of the GradNI game optimization scheme presented in the paper (see Citation).

## Installation

Requires MATLAB 2017b or later.

## Usage

To run the program use
```
function [res,x1] = gradNIGAN(fun, gradfun, n, N, x0, X, Z, eta, rho, tol, maxit, verbose)
```
The inputs to the program are
```
fun         - evaluate function value for each player i using fun(i,x)
gradfun     - evaluate gradient for each player i using gradfun(i,x)
n           - dimension of x_i
N           - number of players
x0          - initial guess, it has two parts, [w1, w2] (we assume only two player
X           - real data, nxp1 matrix
Z           - fake data, nxp2 matrix.
eta         - perturbation used in constructing V_i
rho         - step-size for descent on GNI
tol         - desired convergence tolerance
maxit       - maxinum number of iterations for the algorithm
```

The outputs of the program are
```
res         - array in which each row is: iter# V 0.5*norm(df)^2
x1          - final iterate
```

## Testing

Two test examples are provided in the tests folder.

1. Change directory to the `tests` folder and run the file `demo_GAN.m` to see a demo of the Linear GAN game described
in the paper. The optimizer will be run on a synthetic problem with 2 players and will plot the convergence of the squared gradient of the GNI function.

2. Run the file `demo_Q.m` to see a demo for various quadratic game payoffs. The code includes synthetic data generation and optimization for
    * Bilinear Games
    * Quadratic games with convex, strictly-convex, and indefinite payoff functions.
After running the code, a plot will be made on the convergence of the gradient of the GNI function.


## Citation

If you use the software, please cite the following (http://proceedings.mlr.press/v97/raghunathan19a/raghunathan19a.pdf):

```
@inproceedings{gnigan,
  author    = {Arvind U. Raghunathan and
               Anoop Cherian and
               Devesh K. Jha},
  title     = {Game Theoretic Optimization via Gradient-based Nikaido-Isoda Function},
  year      = {2019},
  booktitle = {ICML}
}
```

## Contact

For questions and comments, please write to: Arvind Raghunathan (raghunathan@merl.com), Anoop Cherian (cherian@merl.com), Devesh Jha (jha@merl.com).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for our policy on contributions.

## License

Released under `AGPL-3.0-or-later` license, as found in the [LICENSE.md](LICENSE.md) file.

All files:

```
Copyright (c) 2019,2023 Mitsubishi Electric Research Laboratories (MERL).

SPDX-License-Identifier: AGPL-3.0-or-later
```
