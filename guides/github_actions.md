# Github Actions

GitHub Actions makes it easy to automate all your software workflows, now with world-class CI/CD. Build, test, and deploy your code right from GitHub. Make code reviews, branch management, and issue triaging work the way you want.

## Common example

There is an example for project which use:
- Postgres
- RSpec
- Rubocop
- Brakeman

Create a workflow file under your project `.github/workflows/verify.yml`

```yml
name: Verify
on: push

jobs:
  rubocop:
    name: Rubocop
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Setup Ruby and install gems
        uses: ruby/setup-ruby@v1
        with:
          bundler-cache: true

      - name: Run Rubocop
        run: bundle exec rubocop --parallel

  brakeman:
    name: Brakeman
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: Brakeman
        uses: artplan1/brakeman-action@v1.2.1
        with:
          flags: "-w2"

  rspec:
    name: RSpec
    runs-on: ubuntu-latest

    services:
      postgres:
        image: postgres:10.8
        env:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: ""
          POSTGRES_DB: postgres
        ports:
          - 5432:5432
        options: >-
          --mount type=tmpfs,destination=/var/lib/postgresql/data
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    env:
      RAILS_ENV: test
      PGHOST: localhost
      PGUSER: postgres

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Setup Ruby and install gems
        uses: ruby/setup-ruby@v1
        with:
          bundler-cache: true

      - name: Create DB
        run: bin/rails db:create db:schema:load

      - name: Run tests
        run: bundle exec rspec
```
