# Variables

* Variable name should reflect its content.
* Variable name should reflect the name of the class of object it contains.
* Variable name should be a noun:
    - in singular form when it holds one value/object at a time;
    - in plural form when it holds a collection of values/objects (`Array`, `ActiveRecord::Relation`).
* Prefer full words instead of abbreviations and shortcuts (except names listed in [Common short variable names](variables.md#common-short-variable-names)).
* Let `params` name to be reserved for `ActionController`, `Grape::API`, or HTTP params in any other form. Try to come up with a meaningful name. Also, you may `attributes` to collect and pass data to `Model.new`, or `data`, `payload` for more generic cases.

## Common short variable names

* `e` - for `error` (e.g.: `rescue => e`)
* `i` - for `index` in loops or iterators
