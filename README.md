# MicroTest

## Ruby's no-nonsense testing framework

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

[See the product page for more details.](http://hopsoft.github.com/micro_test/)
