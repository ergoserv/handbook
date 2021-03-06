# Git

## Branches

Branch                                   | May branch off from   | Must merge back into       | Merge type | Description
---------------------------------------- | --------------------- | -------------------------- | ---------- | -----------
`master`                                 | —                     | `develop`                  | `ff`       | The latest stable version of the code base.
`develop`                                | `master`              | `release/x.x.x`            |            | Default branch to create new branches from and target branch for PRs.
`feature/subject`, `feature/xxx-subject` | `develop`             | `develop`, `release/x.x.x` | `no-ff`    | Use for developing new features. Merged into `develop` or `release/x.x.x` after testing and accepting. `xxx` - issue ID in task tracker like Redmine, `subject` - issue subject.
`hotfix/subject`, `hotfix/xxx-subject`   | `master`              | `master`, `develop`        | `no-ff`    | Maintenance or “hotfix” branches are used to quickly patch production releases. Where `xxx` - issue ID in task tracker like Redmine, `subject` - issue subject.
`release/x.x.x`                          | `develop`             | `master`                   | `no-ff`    | `x.x.x` - release version following [Semantic Versioning](https://semver.org/) conventions by default or project specific version conventions.
`staging`                                | `develop`             | —                          | —          | Represents the current staging server state. develop, feature/*, hotfix/* branches may be merged here directly for testing and demonstration.
`production`                             | `master`              | —                          | —          | Represents the production server state. Always, event when maser is already preparing for the next release. hotfix/* branched may be merged into it directly.

### Master Branch (`master`)

Branch `master` should always contain the version of code deployed to production servers. Rewriting the history of this branch should be avoided.

### Develop Branch (`develop`)

Instead of a single master branch, we use two branches to record the history of the project. The `master` branch stores the official release history, and the `develop` branch serves as an integration branch for features.

- Branch `develop` may contain features that were not released yet.
- Branch `develop` is a default branch to create `feature` branches from.

#### Creating a `develop` branch

```
git branch develop
git push -u origin develop
```

### Feature Branches (`feature/*`)

Each new feature should reside in its own branch, which can be pushed to the central repository for backup/collaboration. But, instead of branching off of `master`, feature branches use `develop` as their parent branch. When a feature is complete, it gets merged back into `develop`. Features should never interact directly with `master`.

Feature branches are generally created off to the latest `develop` branch.


#### Creating a feature branch

```
git checkout develop
git checkout -b feature/subject
```

### Hotfix Branches (`hotfix/*`)

Maintenance or `hotfix` branches are used to quickly patch production releases. Hotfix branches are a lot like release branches and feature branches except they're based on `master` instead of `develop`. This is the only branch that should fork directly off of `master`. As soon as the fix is complete, it should be merged into both `master` and `develop` (or the current release branch), and `master` should be tagged with an updated version number.

#### Creating a `hotfix/` branch

```
git checkout master
git checkout -b hotfix/subject
```

### Staging Branch (`staging`)

Web development flow includes two special branches: `staging` and `production`. These branches are designed to collect code for delivering to staging and production servers respectively.

- Branch `staging` is created from `develop`.
- Branch `staging` should not be merged anywhere, it is used only for deployments to staging servers.
- Developers may continuously merge feature branches (even if they are in WIP status) into `staging` branch and deploy to staging server for reviews. Time to time, `staging` can be reset to `develop` to cleanup redundant merge commits.
- Branch `staging` should always represent the current state of staging server.
- Branch `staging` can be used for automatic deploys to staging servers.

### Production Branch (`production`)

Separate `production` branch can be used for some specific cases to deploy code to production servers.

- Branch `production` should always represent the current state of production server.

## Pull Requests

- Pull Request can be created for `feature/*` or `hotfix/*` branches only, targeting `develop` and `master` branches respectively.
- Pull Request should contain only updates related to the feature or task. Consider creating separate PR if you would like to make any not-so-relevant edits.
- Subject should contain: issue ID(s) and short meaningful description of the PR's contents.
- Description should contain: link to related issue(s) + description of the contents + additional notes (e.g. deployment instructions, etc).
- Subject and description should start with a capital letter, as well as each sentence in the description.
- Prefix `WIP:` (Work-in-Progress) can be used for PR's subjects when PR is not yet ready for review and deployment.

### Updating Pull Requests

- Avoid overwriting the public branches, don't force push branches especially if they were merged to `staging`, have dependent branches, or may be used by other teammates.
- Try to provide meaningful messages for all commits.
- Keep `feature` branch as fresh as possible, merge `develop` branch into it when needed to avoid big divergence and possible merge conflicts.

### Merging Pull Requests

1. Squash unnecessary commits of the `feature` branch.
2. Rebase the `feature` branch onto `develop` branch (especially when the `feature` branch has conflicts against the `develop` branch). Command: `git rebase develop`.
3. Push squashed and rebased `feature` branch to the remote repository.
4. Merge `feature` into `develop` using `--no-ff` option (if pull request approved and ready for deployment). Command: `git merge --no-ff feature/*`.
5. Merge updated `develop` or `feature` branch into the `staging` branch and redeploy staging servers.

Read [Merging vs. Rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing) for better understanding these approaches.

### Merging into `master`

- Branch `master` should always reflect the state of code deployed to production servers.

#### Merging `develop` into `master`

- Merging `develop` into `master` should be always fast-forward (`git merge --ff-only develop`), not merge commits should be created.
- Merge `master` into the `staging` branch and redeploy staging servers right after the production deployment ensure they are in-sync.

## Tags

### Version Tags
Format: `vX.X.X` where `X.X.X` is version following [Semantic Versioning](https://semver.org/) convention or project specific version naming. Usually, this tag marks merge commit produced by `git merge --no-ff release/x.x.x`.

## Commits

* Each commit should be a single *logical change*. Don't make several *logical changes* in one commit. For example, if a patch fixes a bug and optimizes the performance of a feature, split it into two separate commits.
* Don't split a single *logical change* into several commits. For example, the implementation of a feature and the corresponding tests should be in the same commit.
* Commit *early* and *often*. Small, self-contained commits are easier to understand and revert when something goes wrong.
* Commits should be ordered *logically*. For example, if *commit X* depends on changes done in *commit Y*, then *commit Y* should come before *commit X*.

### Messages

* The summary line (ie. the first line of the message) should be descriptive yet succinct. Ideally, it should be no longer than 50 characters. It should be capitalized and written in imperative present tense. It should not end with a period since it is effectively the commit title:
```
# good - imperative present tense, capitalized, fewer than 50 characters
Mark huge records as obsolete when clearing hinting faults

# bad
fixed ActiveModel::Errors deprecation messages failing when AR was used outside of Rails.
```
* After that should come a blank line followed by a more thorough description. It should be wrapped to 72 characters and explain why the change is needed, how it addresses the issue and what side-effects it might have.
* Message (title or body) should contain a reference to the related issue(s) optionally prefixed with keyword: `ERGOPRO-123`, `Fixes #123`, `Resolves #234`, `Related to #456`, `Closes ERGOPRO-345`.
* If a commit A depends on another commit B, the dependency should be stated in the message of commit A. Use the commit's hash when referring to commits. Similarly, if commit A solves a bug introduced by commit B, it should be stated in the message of commit A.

## Configuration

* [Getting Started - First-Time Git Setup](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)

### Configure Your Identity

```
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@ergoserv.com
```

## References

* [Git Book](https://git-scm.com/book/en/v2)
* [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)
* [5 Useful Tips For A Better Commit Message](https://thoughtbot.com/blog/5-useful-tips-for-a-better-commit-message)
* [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
* [git-flow cheatsheet](http://danielkummer.github.io/git-flow-cheatsheet/)
* [Git-flow Cheat Sheet by MrManny](https://www.cheatography.com/mrmanny/cheat-sheets/git-flow/)
* [Semantic Versioning](https://semver.org/)
* [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)
* [Commit messages guide](https://github.com/RomuloOliveira/commit-messages-guide)
* [Merging vs. Rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)
