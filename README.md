# terragrunt_repro

Repro of https://github.com/gruntwork-io/terragrunt/issues/2249

```bash
cd prod/app
terragrunt plan
```

Will fail without moving state file.

For successful run

```bash
mv states/prod/dep_terragrunt.tfstate1 states/prod/dep_terragrunt.tfstate
```

and comment hooks.
