# MicroTest

## The Sinatra of testing frameworks

Testing frameworks often lose their focus and become an end unto themselves.<br />
MicroTest avoids this pitfall with a relentless focus on simplicity.

### Here's what MicroTest brings to the table

* A simple test API
* An awesome test + dev workflow with Pry
* Fast asynchronous test runs with Celluloid

## The API

<table>
  <tr>
    <td>`MicroTest::Test`</td>
    <td>Superclass for all tests.</td>
  </tr>
  <tr>
    <td>`test(desc, &block)`</td>
    <td>
      Defines a test method.
      * `desc` - a description of what is being tested
      * `block` - a block of code which defines the test
    </td>
  </tr>
</table>

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
