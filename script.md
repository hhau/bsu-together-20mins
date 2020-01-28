# Motivation for melding

- statistical model building is often thought of as an iterative approach.
  - build model, check adequacy, refine model if inadequate.
- Very old idea in statistics.
- Empirical evidence suggests that the complexity of the model criticism process is a non-linear function of the size and variety of the data input
  - it gets much much harder as the data get bigger / more numerous 
- Some modern statistical analyses make this tricky, as they require considering multiple data sources, which may differ.

# Complex applied analyses

- with this in mind, let us look at an applied analysis from some other members of the BSU
- $5^{*}$ data sources, each idiosyncratic and requiring significant model development time.
    - Some at the hospital level, some at the nation level. 
    - Some models are also available for some of the data sources, would be nice to reuse them.
- trying to develop a sufficiently nuanced joint model for all these data sources would be prohibitively difficult.
- Really, we'd like to build submodels and combine them together to approximate "the joint model we wish we could specify".
- We will come back to a simplified version of this problem later.

# Notation 1

- Let's introduce some notation
- The usual model criticism/development paradigm considers data $Y_{1}$, and model $\pd_{1}$, with parameters $\phi$, $\psi_{1}$, and iterates until we are satisfied with the properties of $\pd_{1}$. 

# Notation 2

<!-- Adjust this slide - ugly, Rob's better -->

- The situation we seem to find ourselves with examples like the A/H1N1 analysis is that we have multiple information sources and we'd like to build and critique models for each of them. 
- So now we have $\Nm$ models, each having model-specific data and parameters $\psi_{\modelindex}$, but importantly they all share a common quantity $\phi$.
  - $\phi$ does necessarily have to be a "natural" parameter in all of the models, it can be a function of other parameters in any of the submodels.
- A possible solution to this is to go through the model building process for each data source, then combine them after the fact.

# Markov melding

- Markov melding makes this possible.
- to do so, each submodel needs to contain a common component/parameter $\phi$
- Hypothetically, we can the marginalise out $\phi$ from each submodel, and multiply it by some global prior (pooled prior) to obtain a well-specified joint model.
- these conditionals can be impossible to derive, so we instead apply the rules of conditional probability and work with the joint / marginal form here.

# multi stage sampler

- now that we have a well defined joint distribution, we would like to sample the posterior distribution.
- to do so, we employ a multi stage sampler
- We can choose what ever we would like to target in stage one, in this talk we opt for this:

# Specific acceptance probability

## Stage one acceptance

- given our stage one target, the stage one sampler has this following acceptance probability.
- Typical MH:Can use any transition kernel
- produces samples from the stage one target

## Stage two acceptance

- We then use these stage one samples as a proposal for stage two, as this results in a cancellation in the acceptance probability:
- However, there is a subtle issue here, we typically do not know the prior marginal distributions for the common parameter
- The usual solution is to sample the marginal and compute a KDE

# Inter-stage conflict effects

- if the stages disagree about the distribution of the common component, the following can occur.
  - Stage one samples are much wider / different located than the stage-two model's prior
  - This means we evaluate the KDE at points for which we know it is a poor estimate (small probabilities of samples being in that neighbourhood)
  - Hence{, the stage two acceptance probability is dominated by this error}

## Example

## _without_ wsre

- traceplot slide with acceptance probability maths underneath

# weighted-sample self-density ratio estimation

- As we only interact with this distribution via its self-density ratio, we can work on improving our estimate of that.
- The intuition is that we can weight the marginal distribution of interest with a known function, then compute the Jones, weighted KDE.
- This means we can estimate the ratio for improbable values of $\phi$ / small density values.
- These estimates can then themselves be combined and reweighted, to give an estimate of the ratio, that is accurate for a improbable values of phi

## sampling weighted marginals

- given arbitrary joint density, we can samples the weighted marginal s(phi)
- can use this in our weighted density estimates
- Gives us a good ratio estimate for the region of high probability for the weighted marginal

## slide showing densities

- have this lying around somewhere
- Just say we can take a whole bunch of weighting functions.
  - Mathematically much to finiky to get through in a single talk.

## _with_ wsre

- traceplot slide with accept probability math (with ratio bit) underneath

# final bit

- package
- paper
- other examples
