
# Credibility Model

---

# Output Gap

$$
y_t = \alpha \, y_{t-1} + (1-\alpha) \, y_{t+1} + \sigma \, 
\left( r_t - \pi_{t+1} - \rho \right) + \epsilon_{y,t}
$$

---

# Convex Phillips Curve

$$ 
\pi_t - \pi_{t-1} = \beta_t^\star  \left( \pi_{t+1} -
\pi_t \right) + \gamma \tfrac{1}{\delta} \left( \exp\delta y_t - 1
\right) + \epsilon_{\pi, t}
$$

---

# Credibility-Driven Discounting

$$ 
\beta^\star_t = c_t \, \beta
$$

<br/>

$$\beta\in(0,1)$$ fixed parameter

$$c_t\in(0,1)$$ time-varying (endogenous) credibility of CB


---

# Stock of Credibility 

$$
c_t = \psi \, c_{t-1} + (1-\psi) \, s_t
$$

$$ s_t $$ is a new credibility signal


---

# Credibility Signal

$$
s_t = \exp \left[
    -\omega\,\left(
       \pi4_{t-1} - \pi^\mathrm{targ} 
    \right)^2
\right]
$$

---

# Monetary Policy Reaction Function

$$
r_t^\mathrm{unc} = \theta\, r_{t-1} + (1-\theta) \left[
\rho + \pi^\mathrm{targ} + \kappa\left( \pi4_{t+3} - \pi^\mathrm{targ} \right)
\right] + \epsilon_{r,t}
$$

$$
r_t = \max\left\{ r_t^\mathrm{unc}, \, 0 \right\}
$$

