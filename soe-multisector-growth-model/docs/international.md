# Interactions with rest of world

* Balance of transactions and valuations

* Interest parity

* Variables for the rest of the world

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

## Balance of transactions and valuations

* Substitute for the profit and adjustment cost definitions in the
  household budget

* Not a BOP, rather an IIP equation

$$
\begin{gathered}
\nfa^\lcy_t + \nfa^\fcy_t
\newl
=\ 
r^\lcy_{t-1} \, \nfa^\lcy_{t-1}
+ r^\fcy_{t-1} \, \nfa^\fcy_{t-1} \, \tfrac{e_t}{e_{t-1}}
\newl
+\ px_t \, x_t - pm_t \, m_t + \xoff_t
\end{gathered}
$$

where

* $m_t\equiv my_t + mx_t$ is the total import

---

## Interest parity

* Follows from household optimization

* First-order approximation 

$$
r^\lcy_t \approx r^\fcy_t \, \E_t \! \left[ \tfrac{e_{t+1}}{e_t} \right]
$$

* Link the household foreign-currency rate to the world ("risk-free")
  foreign-currency rate

$$
r^\fcy_t = rw^\fcy_t \, u_t
$$

where

* $u_t$ is an ad-hoc country premium to close the model


---

### Rest of world

* Import price 

$$
\begin{gathered}
pm_t = e_t \, pm^\fcy_t \newl
pm^\fcy_t = \cdots
\end{gathered}
$$

* Export price 

$$
\begin{gathered}
px_t = e_t \, px^\fcy_t \newl
px^\fcy_t = tot_t \, pm^\fcy_t
\end{gathered}
$$ 

* Terms of trade

$$
\bDelta \blog tot_t =
\rho_{tot} \ \Delta \blog tot_{t-1} 
+ (1-\rho_{tot})\, \blog \roc{tot}_\ss
+ (1-\rho_{tot})\, \varepsilon_{tot, t}
$$

* World interest rate

$$
rw_t = \cdots
$$

