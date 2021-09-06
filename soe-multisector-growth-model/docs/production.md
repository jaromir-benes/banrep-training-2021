
# Local production

* Production technology with time-varying elasticity of substitution

* Three stages of production
  
* Input factors
    * Local labor
    * Intermediate imports
    * Local capital

* Sticky prices


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

## Productivity

Local productivity process

$$
\bDelta \blog ay_t =
\rho_{ay} \ \Delta \blog ay_{t-1} 
+ (1-\rho_{ay})\, \blog \roc{ay}_\ss
+ (1-\rho_{ay})\, \varepsilon_{ay, t}
$$

---

![[./production-time-varying-elasticity.md]]

---

## Local production stages

##### T-2: Combine local labor and intermediate imports

$$
y_{2,t} = F_2\bigl( my_t, nv_t \bigr)
$$

where

* $nv_t = n_t - \nu\,n_\ss$ is variable labor (excluding overhead labor)


##### T-1: Add capital

$$
y_{1,t} = F_1\bigl( y_{2,t},\ k_{t-1} \bigr)
$$

##### T-0: Sticky prices

$$
y_{t} = y_{1,t}
$$

---

![[production-sticky-prices]]

---

## Production sector total profits

$$
\Pi_{y,t}
\equiv py_t \, y_{t}
- pm_t \, my_t 
- w_t \, n_t
- pu_t \, k_t 
-\ \Xi_{y2,t} - \Xi_{y1,t} - \Xi{py,t}
$$

---

## Final goods distribution

$$
y_t = c_t + i_t + yx_t 
$$


