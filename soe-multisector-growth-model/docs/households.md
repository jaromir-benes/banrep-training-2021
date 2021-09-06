
# Households

$$
\newcommand{\tsum}{\textstyle\sum}
\newcommand{\extern}[1]{\mathrm{\mathbf{{#1}}}}
\newcommand{\local}{\mathrm{local}}
\newcommand{\roc}[1]{\overset{\Delta}{#1{}}}
\newcommand{\ss}{\mathrm{ss}}
\newcommand{\E}{\mathbf{E}}
\newcommand{\ref}{{\mathrm{ref}}}
\newcommand{\fcy}{{\mathrm{fcy}}}
\newcommand{\lcy}{{\mathrm{lcy}}}
\newcommand{\blog}{\mathbf{log}\,}
\newcommand{\bmax}{\mathbf{max}\,}
\newcommand{\bDelta}{\mathbf{\Delta}}
\newcommand{\bPi}{\mathbf{\Pi}}
\newcommand{\newl}{\\[8pt]}
\newcommand{\betak}{\mathit{zk}}
\newcommand{\betay}{\mathit{zy}}
\newcommand{\nfa}{\mathit{nfa}}
\newcommand{\xoff}{\mathit{of}}
\newcommand{\flex}{\mathrm{flex}}
\notag
$$

---

## Household preferences

Lifetime utility function (normalize current period to $0$)

$$
\begin{equation}
\E_0 \sum_{t=0}^{\infty} \beta^t \Bigl( U^{c}_t - U^{nh}_t \Bigr)
\end{equation}
$$

Utility from consumption

$$
\newcommand{\Uc}{\kappa_{c}\ \blog \left( c_t - \chi_c\,{c}_t^\ref \right)}
U^{c}_t \equiv \Uc
$$

Disutility from labor

$$
\newcommand{\Un}{\tfrac{1}{1+\eta}\ n_t{}^{1+\eta}}
U^{nh}_t \equiv \Un
$$

where 

* $c_t^\ref$ is the reference point in household consumption

$$
c_t^\ref \equiv \roc{c}_\ss\, \extern{c}_{t-1}
$$

* $\kappa_{c} \equiv 1 - \chi_c$ is a steady-state
  correction constant ensuring that the marginal utility of consumption
  equals $nn_t \, c_\ss{}^{-1}$ in steady state, a feature of
  modeling convenience,

---

## Intertemporal household budget constraint

Assets and liabilities

* net foreign asset positions in local and foreign currency, respectively
$\nfa^\lcy_t$, $\nfa^\fcy_t$

* claims on local production capital
  $pk_t\, k_t$

Current receipts and outlays

* interest receipts or outlays on the net positions
  $(r^\lcy_{t-1} -1)\, \nfa^\lcy_{t-1}$,
  $(r^\fcy_{t-1} -1)\, \nfa^\fcy_{t-1} \tfrac{e}{e_{t-1}}$

* current receipts from capital rentals (user cost of capital received)
$pu_t\, k_{t-1}$

* current receipts from labor income, $w_t n_t$

* current receipts from selling newly installed capital, $pk_t\,i_t$

* current outlays on consumption goods, $-pc_t \, c_t$,

* current outlays on investment goods, $-pi_t \, i_t$, including investment
  adjustment cost $\Xi_{i,t}$

* period profits received from local producers, $\Pi_{y,t}$, exporters, $\Pi_{x,t}$

* lump-sum receipts for all adjustment costs (serviced by households),
  $\Xi_{h,t}$

$$
\begin{gathered}
pk_t \, k_t + \nfa^\lcy_t + \nfa^\fcy_t
\newl
=\ 
(1 - \delta)\, pk_t \, k_{t-1} 
+ r^\lcy_{t-1} \, \nfa^\lcy_{t-1}
+ r^\fcy_{t-1} \, \nfa^\fcy_{t-1} \, \tfrac{e_t}{e_{t-1}}
\newl
+ \ w_t \, n_t + pu_t \, k_{t-1} - pc_t \, c_t + \left(pk_t - pi_t\right) i_t - \Xi_{i,t} 
\newl
+ \ \bPi_{y,t} + \bPi_{x,t} + \extern{\Xi}_{h,t} + \xoff_t
\end{gathered}
$$


Lagrange multiplier associated with the budget constraint is denoted by
$vh_t$ (shadow value of nominal household wealth)


---

## Real wage rigidities

Wage rates

* Actual wage rate $w_t$

* Wage rate (hypothetical flexible rate) in the Lagrangian, $w^\flex_t$

Wage adjustment process

$$
\blog \frac{w_t}{pc_t} 
= \rho_{w} \ \blog \kappa_w \frac{w_{t-1}}{pc_{t-1}}
+ \left(1-\rho_w\right) \ \blog \frac{w^\flex_t}{pc_t}
+ \epsilon_{w,t}
$$

where 

* $\kappa_w \equiv \roc{w}_\ss \ \roc{pc}_\ss{}^{-1}$ is a steady-state
  correction constant

*  $\rho_w\in[0,\,1)$ is an autoregression parameter.

---

## Investment adjustment/installation cost


$$
\Xi_{i,t}
\equiv 
\tfrac{1}{2} \, \xi_{i} \, pi_t \, \extern{i}_t \, \Bigl( \mathbf{\Delta log\ } i_t - \blog \kappa_{i} \Bigr)^2 \\[5pt]
$$

where

* $\xi_i$
is an investment adjustment/installation cost intensity parameter

* $\kappa_{i} \equiv \roc{\imath}_\ss$
is a steady-state correction constant


---

## Capital accumulation

The household purchases investment goods, converts them to newly installed
production capital (paying the adjustment/installation cost in the process)
and adds these to the existing stock of capital

Aggregate capital accumulation equation

$$
k_t = (1-\delta)\ k_{t-1} + i_t
$$


---

## Lagragian for the household optimization problem

The household chooses
$c_t$, $\nfa^\lcy_t$, $\nfa^\fcy_t$, $i_{t}$, $k_t$, $n_t$
to maximize

$$
\E_0 \sum_{t=0}^\infty \beta^t \Bigl[
\Uc + \Un \Bigr] \ \cdots
$$

$$
\begin{multline}
+\ \E_0 \sum_{t=0}^\infty \beta^t\, vh_t\, \Bigl\{
-\left( pk_t \, k_t + \nfa^\lcy_t + \nfa^\fcy_t \right)
\Bigr.
\ \cdots \newl
+\ (1 - \delta)\, pk_t \, k_{t-1} 
+ r^\lcy_{t-1} \, \nfa^\lcy_{t-1}
+ r^\fcy_{t-1} \, \nfa^\fcy_{t-1} \, \tfrac{e_t}{e_{t-1}}
\ \cdots \newl
+ \ w^\flex_t \, n_t + pu_t \, k_{t-1} - pc_t \, c_t + \left(pk_t - pi_t\right) i_t - \Xi_{i,t} 
\ \cdots \newl
+ \ \bPi_{y,t} + \bPi_{x,t} + \extern{\Xi}_{h,t} + \xoff_t
\Bigr. \Bigr\} 
\end{multline}
$$

where $vh_t$ is the Lagrange multiplier on time-$t$ budget constraint

