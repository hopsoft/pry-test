# MicroTest

## The Sinatra of testing frameworks.

### Quick Start

Install

```bash
$ gem install micro_test
```

Experiment

```bash
$ mt --demo
$ mt --help
```

Write

```ruby
require 'micro_test'

class MyTest < MicroTest::Test
  test "some assumption" do
    assert true
  end
end
```

Run

```bash
$ mt
```

Want BDD?

```ruby
class DescribeMyObject < MicroTest::Test
  test "that a feature does something" do
    assert true
  end
end
```


[See the product page for more details.](http://hopsoft.github.com/micro_test/)
