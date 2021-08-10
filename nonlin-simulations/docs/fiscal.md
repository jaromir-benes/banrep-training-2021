# Simple fiscal extension to gap model

$$
\newcommand{\fcy}{\mathrm{fcy}}
\newcommand{\tnd}{\mathrm{tnd}}
\newcommand{\gap}{\mathrm{gap}}
\newcommand{\ss}{\mathrm{ss}}
\newcommand{\fws}{\mathrm{fws}}
$$

![[title-page.md]]

---

## Overview

* Net government assets (NGA) with a fixed rate of dollarization

* Government expenditures split into purchases of goods and services (part
  of demand for GDP) and other net revenues (including other expenditures)

* Government purchases and other net revenues adjust to achieve NGA to GDP ratio
  target in the long run

* Sovereign risk premium responding to NGA to GDP ratio

---

## Dynamic government budget

Net government assets position cumulates from primary deficits and interest
payments

$$
nga_t = rx_t \, nga_{t-1}
+ vg_t
- py_t\, yg_t
$$

where

* $nga_t$ is net government assets (a negative sign means net debt)

* $yg_t$ is real government purchases of goods and services

* $py_t$ is the GDP deflator

* $vg_t$ is other net nominal government revenues

* $rx_t$ is an ex-post effective rate on NGA given by

$$
rx_t = 
(1-\kappa) \, r_{t-1}
+ \kappa \, r_{t-1}^\fcy \, \tfrac{e_t}{e_{t-1}}
$$

* $\kappa\in [0, \, 1]$ is a parameter to control the rate of NGA dollarization

---

## Government purchases

Government purchases are expenditures directly entering aggregate demand
for local GDP

$$
\log yg_t =
c_0\, \log \delta\bar{y} \ yg_{t-1}
+ (1-c_0) \, \log yg_t^\tnd
+ c_1 \left( \left[\frac{nga}{4\,ny}\right]_t - \left[\frac{nga}{4\,ny}\right]_\ss \right)
+ \varepsilon_{yg,t}
$$

where 

* $ny_t = py_t \, y_t$ is nominal GDP

* $\delta \bar y$ is the steady-state gross rate of change in real GDP

---

## Other net government revenues

Other net nominal government revenues, $vg_t$, do not enter directly
aggregate demand for local GDP (taxes, transfers, expenditures other than purchases, etc)

<br/>

$$
\left[\frac{vg}{ny}\right]_t = 
c_0 \, \left[\frac{vg}{ny}\right]_{t-1}
+ (1-c_0) \, \left[\frac{vg}{ny}\right]_\ss
- c_1 \left( \left[\frac{nga}{4\,ny}\right]_t - \left[\frac{nga}{4\,ny}\right]_\ss \right)
+ \varepsilon_{vg,t}
$$


Define for further use

$$
\left[\frac{vg}{ny}\right]_t^\gap = 
\left[\frac{vg}{ny}\right]_t = 
\left[\frac{vg}{ny}\right]_\ss
$$

---

## Sovereign risk

Sovereign risk, $q_t$ measured as the shor-term expected loss (PD $\times$ LGD) responding to the expected value of NGA (including interest) to GDP ratio

$$
q_t = H\!\left( z_t \right)
$$

where

* $z_t$ is a sovereign risk factor (up means deterioration in sovereign ratings)

$$
z_t = -\frac{(1+rx_{t+1}) \, nga_t}{ny_{t+1}}
$$

* $H(z)$ is a generalized logistic function

---

## Risk function

Generalized logistic function

$$
q = H\!(z) \equiv \underline q + \left( \overline q - \underline q \right)
\left[ 
\frac{1}{1 + \exp -\frac{z-\mu}{\sigma} }
\right]^{\exp\nu}
$$

where 

* $\mu$ is a location parameter

* $\sigma$ is a scale parameter

* $\nu$ is a shape parameter

* $\underline q$ is the lower bound 

* $\overline q$ is the upper bound

---

## Feedback to macro: GDP composition

Trend-gap decomposition

$$
y_t = y^\tnd_t \cdot y^\gap_t
$$


Decomposition into private and government demand

$$
y_t = yh_t + yg_t
$$


Definition of private demand trend

$$
yh_t^\tnd = y_t^\tnd \left(1- \left[ \frac{yg}{y} \right]_\ss\right)
$$


Definition of government demand trend

$$
yg_t^\tnd = y_t^\tnd\ \left[ \frac{yg}{y} \right]_\ss
$$


---

## Feedback to macro: Private demand

Output gap equation

$$
\begin{gathered}
\log yh^\gap =
c_0 \, \log yh^\gap_{t-1}
+ c_1 \, \log \left. y^\fws_t \middle/ y_t \right.
- 4\,c_2 \, rr^\gap_t
+ c_4 \, \log re^\gap_t
+ c_5 \, \log yw^\gap_t \\[5pt]
+ \ c_6' \, \log yg^\gap_t
- c_7' \, \left[\frac{vg}{ny}\right]^\gap_t
+ \varepsilon_{yh,t}
\end{gathered}
$$

where 

* $y^\fws_t$ is a proxy for permanent income (normalized so that
$y_\ss=y^\fws_\ss$)

$$
y_t^\fws = \left[1-(1 + rd)^{-1}\right] 
\sum_{k=0}^\infty (1+rd)^{-k} \, y_{t+k}
$$

* $rd\in(0,\,1)$ is a parameter to control discounting in $y_t^\fws$

---

## Feedback to macro: Interest parity

Sovereign credit risk: Arbitrage between sovereign debt issued in different areas but denominated
in the same (foreign) currency

$$
(1 + r_t^\fcy) \, (1 - q_t) = (1 + rw^\fcy_t) 
$$


Currency risk: Arbitrage between sovereign debt issued in local versus foreign currency by
the same (local) government

$$
(1 + r_t) = (1 + r_t^\fcy) \, \frac{e_{t+1}}{e_t}\, (1 + prem_t)
$$

---

