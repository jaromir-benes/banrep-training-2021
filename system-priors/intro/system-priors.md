# Intro to estimation and calibration using system priors

![[title-page.md]]


---

## Priors in bayesian estimation

* Traditionally, priors on individual parameters

* However, more often than not we simply wish to control some properties of the model as a whole system: **system properties**

* And not so much the individual parameters


---

## Examples of system properties

* Model-implied correlation between output and inflation

* Model-implied sacrifice ratio

* Frequency response function from output to potential output (band of periodicities ascribed to potential output)

* Suppress secondary cycles in shock responses (e.g. more than 90% of a shock response has to occur within the first 10 quarter)

* Make sure a type 2 policy error is costly (delays in the policy response to inflationary shocks calls for a larger reaction later)

* Anything...

* Even **qualitative** properties (e.g. sign restrictions) can be expressed
  as system priors 

---

## System priors formally


Posterior density

$$
\underbrace{ \ p\left(\theta \mid Y, m \right) \ }_{ \text{Posterior}}
\propto
\underbrace{\ p\left(Y \mid \theta, m\right)\ }_{\text{Data likelihood}}
\times 
\underbrace{\ p\left(\theta \mid m\right) \ }_{\text{Prior}}
$$



Prior density typically consists of independent marginal priors

$$
p\left(\theta \mid m \right) =
p_1\left(\theta_1 \mid m \right)
\times
p_2\left(\theta_2 \mid m \right)
\times \cdots \times
p_n\left(\theta_n \mid m \right)
$$



Complement or replace with density involving a property of the model as a whole, $h\left(\theta\right)$

$$
p\left(\theta \mid m \right) =
p_1\left(\theta_1 \mid m \right)
\times \cdots \times
p_n\left(\theta_n \mid m \right)
\times
{\color{highlight}
q_1\bigl(h(\theta)\mid m\bigr)
\times \cdots \times
q_k\bigl(h(\theta)\mid m\bigr)
}
$$



---

## Benefits of system priors in estimation

* A relatively low number of system priors can push parameter estimates into a region where the properties of the model as a whole make sense and are well-behaved…

* …without enforcing a tighter prior structure on individual parameters



---

## Non-bayesian interpretation of priors: Penalty/shrinkage

* Shrinkage (or penalty) function

* Keep the parameters close to our “preferred” values

* ”Close” is defined by the shape/curvature of the shrinkage/penalty function

* Example: Normal priors are equivalent to quadratic shrinkage/penalty


---

## Priors in calibration: Maximize prior mode

* Exclude/disregard data likelihood

* Only maximize prior mode


* Case 1: only independent priors on individual parameters
<br/>
$\Rightarrow$ modes of marginals

$$
p\left(\theta \mid m \right) =
p_1\left(\theta_1 \mid m \right)
\times \cdots \times
p_n\left(\theta_n \mid m \right)
\times \cdots
$$


* Case 2: only a small number of system priors
<br/>
$\Rightarrow$ very likely underdetermined (singular)

$$
p\left(\theta \mid m \right) = 
q_1\bigl(h(\theta)\mid m\bigr)
\times \cdots \times
q_k\bigl(h(\theta)\mid m\bigr)
$$


* Case 3: Combination of priors on individual parameters and system priors
<br/>
$\Rightarrow$ deviate as little as possible from the "preferred" values of
parameters while delivering sensible system properties
$$
p\left(\theta \mid m \right) =
p_1\left(\theta_1 \mid m \right)
\times \cdots \times
p_n\left(\theta_n \mid m \right)
\times
q_1\bigl(h(\theta)\mid m\bigr)
\times \cdots \times
q_k\bigl(h(\theta)\mid m\bigr)
$$


---

## Implemenation in IrisT

The following `@Model` class functions (methods) can be used to construct a
`@SystemProperty` object for efficient evaluation of system properties

| Function | Description |
|---|---|
| `simulate` | Any kind of simulation, including complex simulation design |   
| `acf` | Autocovariance and autocorrelation functions |
| `xsf` | Power spectrum and spectral density functions |
| `ffrf` | Filter frequency response function |

