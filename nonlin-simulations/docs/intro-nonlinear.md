# Intro to simulating nonlinear models<br/>with model-consistent expectations


![[title-page.md]]

---

## System of nonlinear equations with model-consistent expectations



$$
\newcommand{\Et}{\mathrm{E}_t}
\newcommand{\E}[1]{\mathrm{E}_{#1}\!}
$$

System of $n$ nonlinear conditional-expectations equations

$$
\begin{gathered}
\E{t}\, \Bigl[ f_1\bigl( x_{t-1}, x_t, x_{t+1}, \epsilon_t \bigm| \theta \bigr) \Bigr] = 0 \\[10pt]
\vdots \\[10pt]
\E{t} \, \Bigl[ f_n\bigl( x_{t-1}, x_t, x_{t+1}, \epsilon_t \bigm| \theta \bigr) \Bigr] = 0 \\[40pt]
\end{gathered}
$$

<br/>

* Vector of $n$ variables:
$x_t = \left[
x_t^1, \,
\dots, 
x_t^n
\right]'
$

* Vector of $s$ shocks:
$\epsilon_t = \left[
\epsilon_t^1, \,
\dots, 
\epsilon_t^s
\right]'$

* Vector of $p$ parameters:
$\theta_t = \left[
\theta_t^1, \,
\dots, 
\theta_t^p
\right]'$


* Conditional expectations of shocks:
$\E{t-1} \left[\epsilon_t\right] = \E{t-2} \left[\epsilon_t\right] = \cdots = 0$

* Conditional higher moments:
$\E{t-1}\left[ \epsilon_t\, \epsilon_t{}' \right] =
\E{t-2}\left[ \epsilon_t\, \epsilon_t{}' \right] =
\cdots = \Omega, \dots$


---

## Methods for nonlinear simulations

Characteristics | Local approximation | Global approximation | Stacked time 
---|:---:|:---:|:---:
Solution form | Function | Function | Sequence
Explicit terminal | <span style="color:grey">✖︎</span> | <span style="color:grey">✖︎</span> | <span style="color:green">✔︎</span>
Global nonlinearities | <span style="color:grey">✖︎</span> | <span style="color:green">✔︎</span> | <span style="color:green">✔︎</span>
Stochastic nonlinearities | <span style="color:green">✔︎</span> | <span style="color:green">✔︎</span> | <span style="color:grey">✖︎</span>
Automated design | <span style="color:green">✔︎</span> | <span style="color:grey">✖︎</span> | <span style="color:green">✔︎</span>
Large scale models | <span style="color:green">✔︎</span> | <span style="color:grey">✖︎</span> | <span style="color:green">✔︎</span> 
Computational load | Increasing | Large | Manageable |

---

## Local approximation methods

##### Non-stochastic steady state

* A "fixed point" calculated under the following "non-stochastic" assumptions

$$
\begin{gathered}
\epsilon_t = 0 \\[5pt]
\mathrm E_{t-k}\! \left[ \epsilon_t \right] = 0 \\[5pt]
\mathrm E_{t-k}\! \left[ \epsilon_t\, \epsilon_t{}' \right] = 0 \\[5pt]
k = 1, \dots, \infty
\end{gathered}
$$

* Stationary steady state: characterized by a single number, $\bar x$

$$
\bar x_t = \bar x 
$$

* Steady growth path with a constant difference: characterized by two
  numbers, $\bar x_t$ and $\Delta \bar x$,
  at a particular yet arbitrary snapshot along the path

$$
\bar x_t = \bar x_{t-1} + \Delta \bar x
$$

* Steady growth path with a constant rate of change: characterized by $\bar
  x_t$ and $\delta \bar x$, after logarithm, conceptually the same as the
  constant difference case

$$
\bar x_t = \bar x_{t-1} \cdot \delta \bar x
$$

$$
\log \bar x_t = \log \bar x_{t-1} + \log \delta \bar x
$$

* A noteworth special case: unit root process with zero difference/rate of
  change – flat in steady state but not stationary (not pinned down to a
  fixed number)

$$
x_t = x_{t-1}
$$

---

## Local approximation methods

##### Deviations from non-stochastic steady state

Vector of deviations from steady path

$$
\hat x_t = \left[
\hat x_t^1,
\dots,
\hat x_t^n
\right]'
$$

$$
\hat x^i_t = x_t^i - \bar x^i_t \qquad \text{or} \qquad \hat x_t^i = \log x_t^i - \log \bar x_t^i 
$$

Find a function approximated around the nonstochastic steady state by terms
up to a desired order, with coefficient matrices (solution matrices) 
$A_0$, $A_1$, $A_2$, $\dots$, $B$

$$
\hat x_t = A_0 + A_1\ \hat x_{t-1} + \hat x_{t-1}' \ A_2\ \hat x_{t-1} + \ \cdots\ 
+ B_1 \ \epsilon_t  +  \epsilon_t' \ B_2\ \epsilon_t + \ \cdots
$$

that are consistent with the original system of equations up to a desired
order

<br/>

<br/>

The coefficient matrices $A_0, A_1, \ A_2,\ A_3, \ \dots, B_1, B_2,\ \dots$   dependent on

* the 1st, 2nd, ..., $k$-th order Taylor expansions of the original
  functions $f_1,\ \dots,\ f_k$
* model parameters $\theta$


The higher-order coefficient matrices $A_2, A_3, \dots, B_2,
B_3 \ \dots$ also dependent on

* the higher moments of shocks $\Omega, \dots$


---

## Sequential calculation of local approximate solutions

1. Calculate non-stochastic steady state

1. Use generalized Schur decomposition to determine the first-order
   solution matrices

1. Based on steps 1 and 2, calculate second-order solution matrices

1. Based on steps 1, 2, and 3, calculate third-order solution matrices

--- 

## Global approximation

Find a parametric policy ("solution") function $g$

$$
x_t = g\left(x_{t-1}, \epsilon_t \ \middle|\ \theta, \Omega, \dots \right)
$$

consistent with the original system taking into account the
expectations operator

$$
\begin{gathered}
\E{t}\, \Bigl[ f_1\bigl( x_{t-1}, g\left(x_{t-1}, \epsilon_t\right),
g\left(g(x_{t-1}, \epsilon_t), \epsilon_{t+1})\right) \bigm| \theta \bigr) \Bigr] = 0 \\[10pt]
\vdots
\end{gathered}
$$

The function $g$ is a parameterized global approximation of the true function, e.g. parameterized sum of polynominals, function over a discrete grid of points, etc.

Policy function method versus parametrized expectations method

---

## Stacked time

Find a sequence of numbers, $x_1, \dots, x_T$ that comply with the original
system of equations stacked $T$ times underneath each other **dropping** the
expectations operator

$$
\begin{gathered}
f_1\left( x_{-1}, x_1, x_{2}, \epsilon_1 \ \middle| \ \theta \right) = 0 \\[10pt]
\vdots \\[10pt]
f_n\left( x_{t-1}, x_t, x_{2}, \epsilon_1 \ \middle| \ \theta \right) = 0 \\[10pt]
\vdots \\[10pt]
\vdots \\[10pt]
f_1\left( x_{T-1}, x_T, x_{T+1}, \epsilon_T \ \middle| \ \theta \right) = 0 \\[10pt]
\vdots \\[10pt]
f_n\left( x_{T-1}, x_T, x_{T+1}, \epsilon_T \ \middle| \ \theta \right) = 0
\end{gathered}
$$

Initial condition $x_{-1}$ given

Terminal condition $x_{T+1}$ needs to be determined

---

## Combining anticipated and unanticipated shocks in stacked time


By design, all shocks included within one particular simulation run are
known/seen/anticipated throughout the simulation range

Simulating a combination of anticipated and unanticipated shocks means

* split the simulation range into sub-ranges by the occurrence of unanticipated shocks
* run each sub-range as a separate simulation, taking the end-points of the previous sub-range simulation as initial condition
* make sure you run a sufficient number of periods in each sub-simulation

