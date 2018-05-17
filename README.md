[![Lines of Code](http://img.shields.io/badge/lines_of_code-378-brightgreen.svg?style=flat)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Maintainability](https://api.codeclimate.com/v1/badges/139cded3012a4e543287/maintainability)](https://codeclimate.com/github/hopsoft/pry-test/maintainability)
[![Build Status](http://img.shields.io/travis/hopsoft/pry-test.svg?style=flat)](https://travis-ci.org/hopsoft/pry-test)
[![Coverage Status](https://img.shields.io/coveralls/hopsoft/pry-test.svg?style=flat)](https://coveralls.io/r/hopsoft/pry-test?branch=master)
[![Downloads](http://img.shields.io/gem/dt/pry-test.svg?style=flat)](http://rubygems.org/gems/pry-test)
[![Join the chat at https://gitter.im/hopsoft/pry-test](http://img.shields.io/badge/gitter-chat-brightgreen.svg?style=flat)](https://gitter.im/hopsoft/pry-test)

_Formerly known as [MicroTest](https://rubygems.org/gems/micro_test)._

# PryTest

A small test framework that supports debugging test failures & errors when they happen.

## Values

* __Simplicity__ - writing tests should be easy & devoid of friction
* __Intelligibility__ - tests should be readable & unambiguous
* __Immediacy__ - test failures should be dealt with quickly when they occur

## Benefits

* A simple test API
* An awesome `fail` `pry` `pass` workflow
* Optional async test runs

[An important note on debugging test failures with Pry.](https://github.com/hopsoft/pry-test/wiki/Debug-Test-Failures-with-Pry#gemfile-considerations)

## The API

Everything you need to know about PryTest's API is outlined here.

<table>
  <tr>
    <td><code>PryTest::Test</code></td>
    <td>Superclass for all test classes.</td>
  </tr>
  <tr>
    <td><code>test(desc, &block)</code></td>
    <td>
      Defines a test method.
      <ul>
        <li><code>desc</code> - a description of what is being tested</li>
        <li><code>&block</code> - a block of code which defines the test</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><code>assert(value)</code></td>
    <td>
      Verifies the truthiness of a value.
      <ul>
        <li><code>value</code> - the value to assert</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><code>refute(value)</code></td>
    <td>
      Verifies the falsiness of a value.
      <ul>
        <li><code>value</code> - the value to refute</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><code>before(&block)</code></td>
    <td>
      A callback that runs before each test method.
      <ul>
        <li><code>&block</code> - the block of code to execute</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td><code>after(&block)</code></td>
    <td>
      A callback that runs after each test method.
      <ul>
        <li><code>&block</code> - the block of code to execute</li>
      </ul>
    </td>
  </tr>
</table>

### A Complete Example

The entire public interface is used in this basic example.

```ruby
class MathTest < PryTest::Test

  before do
    # runs before each test method
  end

  after do
    # runs after each test method
  end

  test "basic addition" do
    assert 2 + 2 == 4
  end

  test "all is right in the world" do
    refute 0 > 1
  end
end
```

## Get Started

PryTest ships with a demo so you can try it out easily.

```sh
gem install pry-test
pry-test --help
pry-test --demo
```

Try some advanced features.

```sh
pry-test --demo --async
pry-test --demo --disable-pry
```

## Testing Your Own Projects

PryTest assumes your test directory is located at `PROJECT_ROOT/test`;
however, this isn't a requirement. You can indicate your test directory location.

```sh
pry-test /path/to/test/dir
```

If you have multiple versions of PryTest installed,
it's safest to run your tests with `bundle exec`.

```sh
bundle exec pry-test /path/to/test/dir
```

PryTest is small & unobtrusive.
It plays nice with other test frameworks, & can be introduced to existing projects incrementally.

## Advanced

[See the wiki](https://github.com/hopsoft/pry-test/wiki)
to troubleshoot or get help with more advanced topics.
