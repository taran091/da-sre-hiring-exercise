# DeviantArt Site Reliability Engineer Hiring Exercise

In this exercise, we'll be testing your familiarity working with helm charts, k8s, python APIs, through implementing new systems and updating existing code and systems. This exercise and our submit script both assume you're operating in a unix based shell, and without this setup, our submit script will likely not pull the details we need to see how you did on the exercise.

Setup steps:

- Install some sort of local kubernetes on your computer (e.g. minikube, Rancher desktop)
- Sign up for a free developer account and acquire an app_id through: https://openexchangerates.org/

Guiding principals as you work through the exercise:

- Fix what's broken; part of the exercise is to see how you work with existing code/setups, so if there are issues with code that already exists, do not completely blow away the existing setup, rather correct what isn't working.
- If something is unclear, make reasonable assumptions about what's being asked. Some steps have multiple ways to succeed by design. We're looking for what decisions you make and why, so please detail any assumptions you made when sending your results in at the end.

Exercise:

Using the beginnings of an application in the `app` directory, and the existing unfinished charts in `fastapi`, write and build a container for a simple fastapi currency converter service, then deploy this service into minikube.

Requirements for this app and setup are as follows:
  - Work in a dedicated kubernetes context and namespace, separate from anything already existing on your machine, so that your final submission will include all the relevant details and nothing unrelated to our exercise.
  - Use historical currency conversion data available through APIs at https://openexchangerates.org
  - Make the app available on hostname `localhost` on port 8000.
  - The app should accept a GET to `/date/{date}` where `{date}` is numeric and represents seconds since epoch, and returns a list of `currency` (3 digit string) and `rate` (float) for all currencies.
  - The app should accept a POST to `/` that accepts a `date` (numeric, seconds since epoch), `from_currency` (3 digit string), `to_currency` (3 digit string), and an `amount` (float) as inputs, and returns both the final `amount`, and the `exchange_rate` with respect to the `from_currency`.
  - Integrate and expose a prometheus exporter in python using the `prometheus-client` library that exports the current conversion rates as `conversion_rate` with proper `currency` labels.
  - Deploy prometheus in the minikube cluster with an ingress with hostname `localhost` on port 8080.
  - Get the `currency-converter` metrics that are exposed from the app into Prometheus.

Steps to properly submit the exercise:

- Commit all your changes to this repository.
- Ensure `bash`, `curl`, and `kubectl` commands are available and functional.
- Make sure you're in the kubernetes context and namespace that has all your resources as the next step will run `kubectl` to capture deployment details.
- Run the `./submit.sh` script to check your local environment and package your git log into a `.txt` file to send to us.
  - Warning: this will by design pull resources and details from the current kubernetes context and namespace, so you need to work in a context/namespace dedicated to this exercise, in order to avoid sending us details for other deployments on your system.
- Send the resulting `hiring-test-<username>.txt` file directly to da-sre-hiring-exercise@wix.com for us to review, along with any details you want us to know.

Thank you for taking the time to complete our hiring test!
