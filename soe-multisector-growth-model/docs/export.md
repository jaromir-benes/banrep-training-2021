# Export production

* Production technology with time-varying elasticity of substitution

* Two stages of production
  
* Input factors
    * Local components
    * Re-exports

* Exporters are price takers

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

## Productivity in export production

Export productivity process

$$
\bDelta \blog ax_t =
\rho_{ax} \ \Delta \blog ax_{t-1} 
+ (1-\rho_{ax}) \, \blog \roc{ax}_\ss
+ (1-\rho_{ax})\, \varepsilon_{ax, t}
$$

---

## Export production stages

##### T-1: Combine local components with re-exports

$$
x_{1,t} = F_x\left( yx_t, mx_t \right)
$$


##### T-0: Distribute exports worldwide

Exporters are price takers, $px_t$ given by international markets

$$
x_t = x_{1,t}
$$

Period profits inclusive of export volume adjustment cost

$$
\Pi_{x,t} \equiv px_t \, x_t - py_t \, yx_t - pm_t \, mx_t 
- \Xi_{x,t}
$$

where

* $\Xi_{x,t}\equiv \tfrac{1}{2}\, \xi_{x} \, px_t \extern{x}_t \left( \blog x_t - \blog x^\ref_t \right)^2$
is an export volume adjustment cost

* $x^\ref_t \equiv \kappa_x \, \extern{x}_{t+4}$ is a reference level for
  export volume

* $\kappa_x\equiv \roc{x}_\ss{}^{-4}$
is a steady-state correction constant

