# MicroTest

### Testing should be simple.

It bothers me that testing frameworks never seem to resist
the slippery slope of feature creep and eventually become an end unto themselves.
MiniTest is a step in the right direction, but still feels bigger than it should.

#### MicroTest is an experiment to see just how simple a testing "framework" can be.

## Features

* __Opinionated & small...__ just 1 file & 70 lines of code - _can you believe it?_
* __Only one assertion is available:__ `assert` - _since this is the heart of testing_
* __Tests run in random order__ - _to prevent the bad practice of run order depenencies_
* __Plays nice with others__ - _easy to introduce to an existing code base_

## Install

```bash
gem install micro_test
```

## API

* Tests subclass `MicroTest::Test`
* Define tests with `test("description") do...`
* Assert statements with `assert [statement]`
* Run tests with `$mt /path/to/test_file_or_dir` or `MicroTest::Runner.run` from code

That's all there is to learn.

## Examples

```ruby
class MathTest < MicroTest::Test

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

end
```
