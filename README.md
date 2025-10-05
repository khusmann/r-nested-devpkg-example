# Nested Development Packages in R: Example Repo

This repository demonstrates a pattern for managing **project-specific
development scripts** in R by creating a nested development package inside your
main application package.

For more background, rationale, and detailed examples, see my blog post:
[A More Customizable Golem: Nested Development Packages in R](http://www.kylehusmann.com/posts/2025/r-nested-development-packages)

---

## Getting Started

### Example Projects

The repo includes two example projects:

1.  **Minimal setup** -- `myapp/myapp.Rproj`

2.  **renv-based setup** -- `myapp-renv/myapp.Rproj`

---

### Minimal Setup

1.  Clone the repo and open `myapp/myapp.Rproj` in RStudio or Positron.

2.  On project load, you should see:

```
ℹ Loading myapp.dev
```

3.  If `pkgload` is not installed, you'll see a warning. Install it and restart
    your session.

4.  Once loaded, you can call development functions like:

```
myapp.dev::run()
myapp.dev::deploy()

```

### renv Support

The `myapp-renv` project shows how to integrate **renv** with a dev package:

1.  Clone the repo and open `myapp-renv/myapp.Rproj` in RStudio or Positron.

2.  Run `renv::restore()` to synchronize all package versions.

3.  Restart your session to have `myapp.dev` loaded in a controlled environment.

### Deployment Notes

- The dev package should **not** be included in production deployments.

- A common approach: clone a fresh repo, snapshot dependencies **excluding
  dev**, and deploy using `rsconnect::deployApp()`. (See
  `myapp-renv/dev/R/deploy.R` for an example)

### Final Notes

- Remember to restart your R session after updating the dev package.

- Update the `NAMESPACE` of your dev package with `devtools::document("dev")`
  when changing exports.

- For a full discussion and detailed rationale, see the linked blog post above.

---

### Example Dev Functions

| Function              | Description                                |
| --------------------- | ------------------------------------------ |
| `myapp.dev::run()`    | Launches the Shiny app in development mode |
| ---                   | ---                                        |
| `myapp.dev::deploy()` | Example deployment function                |
