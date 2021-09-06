# Gross domestic product (Value added)

* Nominal GDP easy to introduce based on expenditure accounting

* No single "correct" real GDP definition exists in a multi-sector model

* Use Törnqvist index (good approximation for chain linking)

---

### Nominal GDP

$$
ngdp_t = 
pc_t \, c_t + pi_t\,i_t + px_t \, x_t - pm_t m_t
$$

---

### Real GDP (growth)

* Real GDP can only be introduced as an index

* No interpretation/meaning of the **level** itself - cannot be e.g. used in
  steady-state comparative static analysis

* Real GDP level index is not "co-integrated" with any of the other real
  variables (the definition introduces another unit root)

$$
\roc{gdp}_t = 
w_{c,t} \,\roc{c}_t
+ w_{i,t} \,\roc{\imath}_t
+ w_{x,t} \,\roc{x}_t
- w_{m,t} \,\roc{m}_t
$$

where 

* $w_{c,t} \equiv \tfrac{1}{2}\left[
\frac{pc_t\,c_t}{ngdp_t} +
\frac{pc_{t-1}\,c_{t-1}}{ngdp_{t-1}}
\right]$
is the consumption weight 

* etc...

