# Query Objects

## Introduction

Query Objects are useful to extract ActiveRecord scopes or complex SQL queries into their own classes, which would otherwise clutter ActiveRecord models.

## Conventions

* Queries go under the `app/queries` directory.
* Query class name should have suffix `Query` (e.g. `AuthorsQuery`).
* Query class name should start with primary model name used in query in plural form (e.g. `AuthorsWithBooksQuery`).
* Consider creating base query class for the model (e.g. `AuthorsQuery`) and subclasses for more specific cases (e.g. `AuthorsWithBooksQuery < AuthorsQuery`).
* Query object should return `ActiveRecord::Relation` object.
* Use scope `none` for the cases when respond with empty collection is required.
* Define only one public method `#perform`.
* Use [auxiliary_rails](https://github.com/ergoserv/auxiliary_rails) gem.

## References

* [Delegating to Query Objects through ActiveRecord scopes](http://craftingruby.com/posts/2015/06/29/query-objects-through-scopes.html)
* [Essential RubyOnRails patterns — part 2: Query Objects](https://medium.com/selleo/essential-rubyonrails-patterns-part-2-query-objects-4b253f4f4539)
* https://github.com/andypike/rectify#query-objects
* https://github.com/infinum/rails-handbook/blob/master/Design%20Patterns/Query%20Objects.md
