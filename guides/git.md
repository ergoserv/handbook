# Git

## Branches

Branch                                   | May branch off from   | Must merge back into       | Merge type | Description
---------------------------------------- | --------------------- | -------------------------- | ---------- | -----------
`master`                                 | —                     | `develop`                  | `ff`       | The latest stable version of the code base.
`develop`                                | `master`              | `release/x.x.x`            |            | Default branch to create new branches from and target branch for PRs.
`feature/subject`, `feature/xxx-subject` | `develop`             | `develop`, `release/x.x.x` | `no-ff`    | Use for developing new features. Merged into `develop` or `release/x.x.x` after testing and accepting. `xxx` - issue ID in task tracker like Redmine, `subject` - issue subject.
`hotfix/subject`, `hotfix/xxx-subject`   | `master`              | `master`, `develop`        | `no-ff`    | Maintenance or “hotfix” branches are used to quickly patch production releases. Where `xxx` - issue ID in task tracker like Redmine, `subject` - issue subject.
`release/x.x.x`                          | `develop`             | `master`                   | `no-ff`    | `x.x.x` - release version following [Semantic Versioning](https://semver.org/) conventions by default or project specific version conventions
`staging`                                | `develop`             | —                          | —          | Represents the current staging server state. develop, feature/*, hotfix/* branches may be merged here directly for testing and demonstration.
`production`                             | `master`              | —                          | —          | Represents the production server state. Always, event when maser is already preparing for the next release. hotfix/* branched may be merged into it directly.


## Develop and Master Branches

## Feature Branches

### Creating a feature branch

```
git checkout develop
git checkout -b feature/subject
```

## Staging and Production Branches

## Maintenance or “hotfix” branches

Maintenance or “hotfix” branches are used to quickly patch production releases. Hotfix branches are a lot like release branches and feature branches except they're based on master instead of develop. This is the only branch that should fork directly off of master. As soon as the fix is complete, it should be merged into both master and develop (or the current release branch), and master should be tagged with an updated version number.

### Creating a hotfix branch

```
git checkout master
git checkout -b hotfix/subject
```

## Tags

### Version Tags
Format: `vX.X.X` where `X.X.X` is version following [Semantic Versioning](https://semver.org/) convention or project specific version naming. Usually, this tag marks merge commit produced by `git merge --no-ff release/x.x.x`.

## Commits

* Each commit should be a single *logical change*. Don't make *logical changes* in one commit. For example, if a patch fixes a bug and optimizes the performance of a feature, split it into two separate commits.
* Don't split a single *logical change* into several commits. For example, the implementation of a feature and the corresponding tests should be in the same commit.
* Commit *early* and *often*. Small, self-contained commits are easier to understand and revert when something goes wrong.
* Commits should be ordered *logically*. For example, if *commit X* depends on changes done in *commit Y*, then *commit Y* should come before *commit X*.

## Messages

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

### Configure Your Identity

```
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@ergoserv.com
```

## References
* [Git Book](https://git-scm.com/book/en/v2)
* [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)
* [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
* [git-flow cheatsheet](http://danielkummer.github.io/git-flow-cheatsheet/)
* [Git-flow Cheat Sheet by MrManny](https://www.cheatography.com/mrmanny/cheat-sheets/git-flow/)
* [Semantic Versioning](https://semver.org/)
