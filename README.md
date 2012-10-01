# MicroTest

## Ruby's no-nonsense testing framework

Testing frameworks often lose their focus and become an end unto themselves.

MicroTest avoids this pitfall with a relentless focus on simplicity.

### Testing should be simple

Here's what MicroTest brings to the table.

* __Simplicity__
  A tiny API with only 4 methods. You'll be up and running faster than ever before.
* __Only 1 Assert Method__
  Forget the copious expections and assert methods from other frameworks and start focusing on what really matters.
* __Small Footprint__
  Weighs in around 140 lines of code. Less code means less to learn and less that can go wrong.
* __Plays Nice__
  Runs side by side with other test frameworks which makes it easy to integrate into existing projects.
* __Random Run Order__
  Prevents the bad practice of run order dependencies by running tests in random order.
* __Customizable
  Output__ Customize test output with pluggable formatters, or give back by writing your own.

## Quick Start

1. Install

```bash
$ gem install micro_test
```

2. Write a test

```ruby
require 'micro_test'
class MyTest < MicroTest::Test
  test "some assumption" do
    assert true
  end
end
```

3. Run tests

```bash
$ mt
```

## The interface

* `MicroTest::Test` Superclass for all tests.
* `test(desc, &block)` Defines a test method.

  * `desc` - a description of what is being tested
  * `&block` - a block of code which defines the test

* `assert(value)` Verifies the truthiness of a value.

  * `value` - the value to assert

* `before(what, &block)` A callback that runs before the specified 'what'.

  * `what` - indicates the callback type

    * `:all` - runs before all tests in the class
    * `:each` - runse before each test in the class

  * `&block` - the block of code to execute

* `after(what, &block)` A callback that runs after the specified 'what'.

  * `what` - indicates the callback type

    * `:all` - runs after all tests in the class
    * `:each` - runse after each test in the class

  * `&block` - the block of code to execute

## Example

```ruby
# /example/test/math_test.rb
class MathTest < MicroTest::Test

  before :all do
    # runs once before all tests
  end

  before :each do
    # runs before each test
  end

  test "addition" do
    assert 2 + 2 == 4
  end

  test "subtraction" do
    assert 2 - 2 == 0
  end

  test "multiplication" do
    assert 2 * 2 == 4
  end

  test "division" do
    assert 2 / 2 == 1 # add a trailing comment if you want a message
  end

  # and one failing test
  test "fail" do
    assert 2 + 2 == 5
  end

  after :each do
    # runs after each test
  end

  after :all do
    # runs once after all tests
  end

end
```

Run tests.

```bash
$ mt
$ mt /example/test
$ mt /example/test/math_test.rb
