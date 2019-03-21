# Git

## Develop and Master Branches

## Feature Branches

### Creating a feature branch

```
git checkout develop
git checkout -b features/subject
```

## Staging and Production Branches

## Maintenance or “hotfix” branches

Maintenance or “hotfix” branches are used to quickly patch production releases. Hotfix branches are a lot like release branches and feature branches except they're based on master instead of develop. This is the only branch that should fork directly off of master. As soon as the fix is complete, it should be merged into both master and develop (or the current release branch), and master should be tagged with an updated version number.

### Creating a hotfix branch

```
git checkout master
git checkout -b hotfix/subject
```


## Links
- https://nvie.com/posts/a-successful-git-branching-model/
- https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow