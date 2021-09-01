# GitHub Actions for Okteto Cloud

## Automate your development workflows using Github Actions and Okteto Cloud
GitHub Actions gives you the flexibility to build an automated software development workflows. With GitHub Actions for Okteto Cloud you can create workflows to build, deploy and update your applications in [Okteto Cloud](https://cloud.okteto.com).

Get started today with a [free Okteto Cloud account](https://cloud.okteto.com)!

## Github Action for Creating a Namespace in Okteto Cloud

You can use this action to create a namespace in Okteto Cloud as part of your automated development workflow.

## Inputs

### `namespace`

**Required**  The name of the Okteto namespace to create.

> Remember that the namespace name must have your github ID as a suffix if you're using Okteto Cloud

### `members`

The list of users that will have access to the namespace on Okteto. Separate them with a comma if you are using more than one. You can use either their Okteto username or their email.

The creator of the namespace will automatically have access to the namespace in Okteto.


## Example usage

This example runs the login action and then activates a namespace.

```yaml
# File: .github/workflows/workflow.yml
on: [push]

name: example

jobs:

  devflow:
    runs-on: ubuntu-latest
    steps:
    
    - uses: okteto/login@master
      with:
        token: ${{ secrets.OKTETO_TOKEN }}
    
    - name: "Create devlopment environments namespace"
      uses: okteto/create-namespace@master
      with:
        namespace: devenvs-cindylopez
        members: rberrelleza,pchico83
```

## Advanced usage

 ### Custom Certification Authorities or Self-signed certificates

 You can specify a custom certificate authority or a self-signed certificate by setting the `OKTETO_CA_CERT` environment variable. When this variable is set, the action will install the certificate in the container, and then execute the action. 

 Use this option if you're using a private Certificate Authority or a self-signed certificate in your [Okteto Enterprise](http://okteto.com/enterprise) instance.  We recommend that you store the certificate as an [encrypted secret](https://docs.github.com/en/actions/reference/encrypted-secrets), and that you define the environment variable for the entire job, instead of doing it on every step.


 ```yaml
 # File: .github/workflows/workflow.yml
 on: [push]

 name: example

 jobs:
   devflow:
     runs-on: ubuntu-latest
     env:
       OKTETO_CA_CERT: ${{ secrets.OKTETO_CA_CERT }}
     steps:
     
     - uses: okteto/login@master
       with:
         token: ${{ secrets.OKTETO_TOKEN }}
     
    - name: "Create devlopment environments namespace"
      uses: okteto/create-namespace@master
      with:
        namespace: devenvs-cindylopez
        members: rberrelleza,pchico83
 ```