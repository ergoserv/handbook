# Query Objects

## Introduction

Query Objects are useful to extract complex SQL queries into their own classes, which would otherwise clutter ActiveRecord models.

## Conventions

* Queries go under the `app/queries` directory.
* Query class name should have suffix `Query` (e.g. `AuthorsQuery`).
* Query class name should start with primary model used in query in plular form (e.g. `AuthorsWithBooksQuery`).
* Query classes should be inherited from `ApplicationQuery` (drop-in template - [application_query.rb](../templates/query_objects/application_query.rb)).
* Query classes should define `query` method where query logic is incapsulated.

## Examples

```ruby
# app/queries/authors_without_books_query.rb
class AuthorsWithoutBooksQuery < ApplicationQuery
  def query
    relation
      .left_joins(:books)
      .where(books: {id: nil})
      .distinct
  end

  protected

  def default_relation
    Author.all
  end
end

# app/queries/authors_with_books_query.rb
class AuthorsWithBooksQuery < AuthorsQuery
  def query(min_book_count: 3)
    relation
      .joins(:books)
      .group(:author_id)
      .having('COUNT(books.id) > ?', min_book_count)
  end

  protected

  def default_relation
    Author.all
  end
end

# usage

AuthorsWithoutBooksQuery.call
AuthorsWithBooksQuery.call(min_book_count: 8)
```

```ruby
# app/queries/application_query.rb
class ApplicationQuery
  attr_reader :relation

  def initialize(relation = nil)
    @relation = relation || default_relation
  end

  def query
    raise NotImplementedError
  end

  def call(*args)
    query(*args)
  end

  def self.call(*args)
    new.call(*args)
  end

  protected

  def default_relation
    raise NotImplementedError
  end
end
```

## References

* [Delegating to Query Objects through ActiveRecord scopes](http://craftingruby.com/posts/2015/06/29/query-objects-through-scopes.html)
* [Essential RubyOnRails patterns — part 2: Query Objects](https://medium.com/selleo/essential-rubyonrails-patterns-part-2-query-objects-4b253f4f4539)
* https://github.com/andypike/rectify#query-objects
* https://github.com/infinum/rails-handbook/blob/master/Design%20Patterns/Query%20Objects.md